//
//  GetComicsRequest.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation

public struct GetComicsRequest: Encodable {
    
    public let limit: Int
    public let offset: Int
    public let startYear: Int
    public let orderBy: ComicOrderByType
    
    public init(
        limit: Int,
        offset: Int,
        startYear: Int,
        orderBy: ComicOrderByType
    ) {
        self.limit = limit
        self.offset = offset
        self.startYear = startYear
        self.orderBy = orderBy
    }
}

public enum ComicOrderByType: String, Encodable {
    
    case focDate
    case onsaleDate
    case title
    case issueNumber
    case modified
}
