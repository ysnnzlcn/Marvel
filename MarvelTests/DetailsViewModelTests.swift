//
//  DetailsViewModelTests.swift
//  MarvelTests
//
//  Created by Yasin Nazlican on 3.09.2021.
//

import XCTest
@testable import Marvel

class DetailsViewModelTests: XCTestCase {

    private lazy var sut = DetailsViewModel(service: MockedServices(), heroModel: heroModel)
    
    private var onLoaderToggled: ((Bool) -> Void)?
    private var onUpdateTable: (() -> Void)?
    
    private var heroModel = HeroModel(id: 0, name: "Hulk", description: "Unstoppable", thumbnail: nil)
    
    
    override func setUp() {
        super.setUp()
        sut.addChangeHandler { [weak self] change in

            switch change {
            case .toggleLoader(let show): self?.onLoaderToggled?(show)
            case .updateTable: self?.onUpdateTable?()
            case .failed: break
            }
        }
    }
    
    private func test_getHeroDetails_thenCheckForItemsState() {
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
        
        var onTableCalled = false
        onUpdateTable = {
            onTableCalled = true
        }
        
        // when
        sut.didLoad()

        // then
        XCTAssertEqual(loaderCallCount, 2)
        XCTAssertTrue(onTableCalled)
        XCTAssertEqual(sut.state.sections[0].items.count, 2)
        XCTAssertEqual(sut.state.sections[1].items.count, 1)
        XCTAssertEqual(sut.title, "Hulk")
    }
}

private struct MockedServices: Services {
    
    func getHeroes(request: GetHeroesRequest, completion: @escaping ValueClosure<NetworkResult<GetHeroesResponse>>) {
        print("Empty implementation")
    }
    
    func getComicsOfHero(heroId: Int, request: GetComicsRequest, completion: @escaping ValueClosure<NetworkResult<GetComicsResponse>>) {
        let comicModel = ComicModel(id: 0, title: "Hulk", description: nil, thumbnail: nil)
        let response = GetComicsResponse(offset: 0, limit: 0, total: 0, count: 0, results: [comicModel])
        completion(.success(response: response))
    }
}
