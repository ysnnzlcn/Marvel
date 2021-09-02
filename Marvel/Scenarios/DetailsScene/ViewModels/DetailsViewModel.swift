//
//  DetailsViewModel.swift
//  Marvel
//
//  Created by Yasin Nazlican on 20.08.2021.
//

import Foundation

public struct DetailsViewModelState {
    
    public var sections = [DetailsTableDataSource.Section]()
    
    public enum Change: StateChange {
        
        case toggleLoader(_ show: Bool)
        case updateTable
        case failed(_ message: String)
    }
}

public final class DetailsViewModel: StatefulViewModel<DetailsViewModelState.Change> {
    
    // MARK: Public Variables
    
    public private(set) var state = DetailsViewModelState()
    public var title: String {
        heroModel.name
    }
    
    // MARK: Private Variables
    
    private let service: Services
    private let heroModel: HeroModel
    
    // MARK: Life-Cycle
    
    public init(
        service: Services,
        heroModel: HeroModel
    ) {
        self.service = service
        self.heroModel = heroModel
    }
    
    // MARK: Public Methods
    
    public func didLoad() {
        makeDataSource(nil) /// Let's show user image and text while they are waiting for comics.
        getComics()
    }
    
    // MARK: Private Methods
    
    private func makeDataSource(_ response: GetComicsResponse?) {
        state.sections = []
        // First Section - Hero
        /// Image Header Cell
        let cellViewModel = DetailsImageAndDescriptionCellViewModel(model: heroModel)
        let firstItem = DetailsTableDataSource.Item(cell: .imageAndDescriptionCell(cellViewModel))
        
        /// Description Cell
        let text = heroModel.description.attributed(font: .regularPoppins(16))
        let secondItem = DetailsTableDataSource.Item(cell: .textCell(text))
        
        let firstSection = DetailsTableDataSource.Section(items: [firstItem, secondItem], title: nil, shouldShowHeader: false)
        state.sections.append(firstSection)
        
        // Second Section - Comics
        if let comics = response?.results {
            var comicItems = [DetailsTableDataSource.Item]()
            
            if comics.isEmpty {
                comicItems = [.init(cell: .textCell(Constants.Comic.noComicFoundText))]
            } else {
                comicItems = comics.map { .init(cell: .comicCell(ComicsTableViewCellViewModel(model: $0))) }
            }
            
            let secondSection = DetailsTableDataSource.Section(items: comicItems, title: Constants.Comic.headerTitle, shouldShowHeader: true)
            state.sections.append(secondSection)
        }
    }
}

// MARK: Networking

extension DetailsViewModel {
    
    private func getComics() {
        emit(change: .toggleLoader(true))
        service.getComicsOfHero(
            heroId: heroModel.id,
            request: Constants.Comic.staticRequest
        ) { [weak self] result in
            
            switch result {
            case .success(let response):
                self?.makeDataSource(response)
                self?.emit(change: .updateTable)
                
            case .failure(let error):
                self?.emit(change: .failed(error))
            }
            
            self?.emit(change: .toggleLoader(false))
        }
    }
}

private enum Constants {
    
    enum Comic {
        
        static let headerTitle = "Comics"
        static let noComicFoundText = "This hero has no comics.".attributed(font: .regularPoppins(18))
        static let staticRequest = GetComicsRequest(
            limit: 10,
            offset: 0,
            startYear: 2005,
            orderBy: .focDate
        )
    }
}
