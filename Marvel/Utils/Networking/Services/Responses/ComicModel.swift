//
//  ComicModel.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation

public struct ComicModel: Decodable {
    
    public let id: Int
    public let title: String
    public let description: String?
    public let thumbnail: Thumbnail?
    
    public init(
        id: Int,
        title: String,
        description: String?,
        thumbnail: Thumbnail?
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
}
