//
//  PaginationHelper.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import Foundation

public final class PaginationHelper {
    
    // MARK: Private Variables
    
    private var totalPageCount = 1
    
    // MARK: Public Read-Only Variables
    
    public private(set) var currentPage = 0
    public var nextPageNumberToFetch: Int { currentPage + 1 }
    public var shouldFetchNextPage: Bool {
        currentPage < totalPageCount
    }
    
    // MARK: Public Methods
}
