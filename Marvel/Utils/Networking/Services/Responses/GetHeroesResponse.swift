//
//  GetHeroesResponse.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation

public struct GetHeroesResponse: Decodable {
    
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [HeroModel]
    
    public init(
        offset: Int,
        limit: Int,
        total: Int,
        count: Int,
        results: [HeroModel]
    ) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}
