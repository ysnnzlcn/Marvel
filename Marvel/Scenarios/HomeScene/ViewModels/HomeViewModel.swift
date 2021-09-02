//
//  HomeViewModel.swift
//  Marvel
//
//  Created by Yasin Nazlican on 02.09.2021.
//

import Foundation

public struct HomeViewModelState {
    
    public fileprivate(set) var items = [HomeTableDataSource.Item]()
    
    /// These are public because of tests purposes.
    public fileprivate(set) var isBusy = false
    
    public enum Change: StateChange {
        
        case toggleLoader(_ show: Bool)
        case insertCells(_ indexes: [IndexPath])
        case showDetails(hero: HeroModel)
        case failed(_ message: String)
    }
}

public final class HomeViewModel: StatefulViewModel<HomeViewModelState.Change> {
    
    // MARK: Public Variables
    
    public private(set) var state = HomeViewModelState()
    
    // MARK: Private Variables
    
    private lazy var paginationHelper = PaginationHelper(limit: Constants.Paginator.limit)
    private let service: Services
    
    // MARK: Life-Cycle
    
    public init(service: Services) {
        self.service = service
    }
    
    // MARK: Public Methods
    
    public func cellsDequeued(at index: Int) {
        let isEndOfContent = (index == state.items.count - 6)
        guard !state.isBusy && isEndOfContent else { return }
        getHeroes()
    }
    
    public func itemSelected(at indexPath: IndexPath) {
        switch state.items[indexPath.row].cell {
        case .heroCell(let cellViewModel):
            emit(change: .showDetails(hero: cellViewModel.model))
        }
    }
    
    // MARK: Helper Methods
    
    private func calculateIndexPathsToReload(from newHeroes: [HeroModel]) -> [IndexPath] {
        let startIndex = state.items.count - newHeroes.count
        let endIndex = startIndex + newHeroes.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

// MARK: Networking

extension HomeViewModel {
    
    public func getHeroes() {
        guard paginationHelper.shouldFetchNextPage else { return }
        emit(change: .toggleLoader(true))
        state.isBusy = true
        
        let request = GetHeroesRequest(limit: paginationHelper.limit, offset: paginationHelper.currentOffset)
        service.getHeroes(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.paginationHelper.nextPageFetched(count: response.count, total: response.total)
                self.state.items += response.results.map {
                    let cellViewModel = HeroTableViewCellViewModel(model: $0)
                    return .init(cell: .heroCell(cellViewModel))
                }
                let indexPaths = self.calculateIndexPathsToReload(from: response.results)
                self.emit(change: .insertCells(indexPaths))
                
            case .failure(let error):
                self.emit(change: .failed(error))
            }
            
            self.emit(change: .toggleLoader(false))
            self.state.isBusy = false
        }
    }
}

private enum Constants {
    
    enum Paginator {
        
        static let limit = 30
    }
}
