//
//  GetComicsResponse.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation

public struct GetComicsResponse: Decodable {
    
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [ComicModel]
    
    public init(
        offset: Int,
        limit: Int,
        total: Int,
        count: Int,
        results: [ComicModel]
    ) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}
