//
//  HomeViewModelTests.swift
//  MarvelTests
//
//  Created by Yasin Nazlican on 3.09.2021.
//

import XCTest
@testable import Marvel

class HomeTests: XCTestCase {
    
    private let sut = HomeViewModel(service: MockedServices())
    
    private var onLoaderToggled: ((Bool) -> Void)?
    private var onUpdateTable: (() -> Void)?
    private var onInsertCells: (([IndexPath]) -> Void)?
    private var onShowDetails: ((HeroModel) -> Void)?
    
    override func setUp() {
        super.setUp()
        sut.addChangeHandler { [weak self] change in
            
            switch change {
            case .toggleLoader(let show): self?.onLoaderToggled?(show)
            case .insertCells(let indexPaths): self?.onInsertCells?(indexPaths)
            case .showDetails(let hero): self?.onShowDetails?(hero)
            case .failed: break
            }
        }
    }
    
    func testInOrder() {
        getHeroesCalled_thenCheckForItemsAndState()
        getHeroesPagingCalled_thenCheckForItemsState()
        heroSelectedCalled_thenCheckForCallback()
    }
    
    private func getHeroesCalled_thenCheckForItemsAndState() {
        // given
        var loaderCallCount = 0
        onLoaderToggled = { show in
            if loaderCallCount == 0 {
                XCTAssertTrue(show)
            } else if loaderCallCount == 1 {
                XCTAssertFalse(show)
            }
            loaderCallCount += 1
        }
        
        var insertedCells = [IndexPath]()
        onInsertCells = { indexPaths in
            insertedCells = indexPaths
        }
        
        // when
        sut.getHeroes()
        
        // then
        XCTAssertEqual(loaderCallCount, 2)
        XCTAssertFalse(insertedCells.isEmpty)
        insertedCells.enumerated().forEach { index, cellIndex in
            XCTAssertEqual(cellIndex.row, index)
        }
        XCTAssertEqual(sut.state.items.count, Constants.limit)
    }
    
    private func getHeroesPagingCalled_thenCheckForItemsState() {
        // given
        var loaderCallCount = 0
        onLoaderToggled = { show in
            if loaderCallCount == 0 {
                XCTAssertTrue(show)
            } else if loaderCallCount == 1 {
                XCTAssertFalse(show)
            }
            loaderCallCount += 1
        }

        var insertedCells = [IndexPath]()
        onInsertCells = { indexPaths in
            insertedCells = indexPaths
        }

        // when
        sut.cellsDequeued(at: 24) /// Since we have 30 items, this will be enough to send paging req.
        sut.cellsDequeued(at: 24) /// Test multiple call prevention.

        // then
        XCTAssertEqual(loaderCallCount, 2)
        XCTAssertFalse(insertedCells.isEmpty)
        insertedCells.enumerated().forEach { index, cellIndex in
            /// We are adding +30 to our index since we already have 30 items in our data source.
            XCTAssertEqual(cellIndex.row, index + 30)
        }
        XCTAssertEqual(sut.state.items.count, 60)
    }
    
    private func heroSelectedCalled_thenCheckForCallback() {
        // given
        var heroModel: HeroModel?
        onShowDetails = { hero in
            heroModel = hero
        }

        // when
        sut.itemSelected(at: IndexPath(row: 0, section: 0))

        // then
        XCTAssertNotNil(heroModel)
        XCTAssertEqual(heroModel?.id, 0) /// Check if first selected item is, first comer from API.
    }
}

private struct MockedServices: Services {
    
    func getHeroes(request: GetHeroesRequest, completion: @escaping ValueClosure<NetworkResult<GetHeroesResponse>>) {
        let heroes: [HeroModel] = Array(0..<Constants.limit).map {
            HeroModel(id: $0, name: "\($0)", description: "\($0)", thumbnail: nil)
        }
        completion(.success(response: GetHeroesResponse(offset: request.offset, limit: Constants.limit, total: Constants.total, count: Constants.limit, results: heroes)))
    }
    
    func getComicsOfHero(heroId: Int, request: GetComicsRequest, completion: @escaping ValueClosure<NetworkResult<GetComicsResponse>>) {
        print("Empty implementation")
    }
}

private enum Constants {
    
    static let limit = 30
    static let total = 60
}
