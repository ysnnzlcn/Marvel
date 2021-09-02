//
//  PaginationHelper.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import Foundation

public final class PaginationHelper {
    
    // MARK: Private Variables
    
    private var totalHeroCount = 1
    
    // MARK: Public Read-Only Variables
    
    public let limit: Int
    public private(set) var currentOffset = 0
    public var shouldFetchNextPage: Bool {
        currentOffset < totalHeroCount
    }
    
    public init(limit: Int) {
        self.limit = limit
    }
    
    // MARK: Public Methods
    
    public func nextPageFetched(count: Int, total: Int) {
        currentOffset += count
        totalHeroCount = total
    }
}
