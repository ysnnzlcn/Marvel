//
//  GetHeroesRequest.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation

public struct GetHeroesRequest: Encodable {
    
    public let limit: Int
    public let offset: Int
    
    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
}
