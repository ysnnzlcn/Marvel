//
//  PaginationHelperTests.swift
//  MarvelTests
//
//  Created by Yasin Nazlican on 3.09.2021.
//

import XCTest
@testable import Marvel

class PaginationHelperTests: XCTestCase {

    private let helper = PaginationHelper(limit: Constants.limit)
    
    func testPaginationHelper() {
        // Test initial state
        XCTAssertEqual(helper.currentOffset, 0)
        XCTAssertEqual(helper.limit, Constants.limit)
        XCTAssertTrue(helper.shouldFetchNextPage)
        
        // Test after successful response
        helper.nextPageFetched(count: 30, total: 60)
        XCTAssertEqual(helper.currentOffset, 30)
        XCTAssertTrue(helper.shouldFetchNextPage)
        
        // Test end of the pages
        helper.nextPageFetched(count: 30, total: 60)
        XCTAssertEqual(helper.currentOffset, 60)
        XCTAssertFalse(helper.shouldFetchNextPage)
    }
}

private enum Constants {
    
    static let limit = 30
}
