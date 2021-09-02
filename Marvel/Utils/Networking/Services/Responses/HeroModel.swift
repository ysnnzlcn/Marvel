//
//  HeroModel.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation

public struct HeroModel: Decodable {
    
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail?
    
    public init(
        id: Int,
        name: String,
        description: String,
        thumbnail: Thumbnail?
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}

public struct Thumbnail: Decodable {
    
    public let path: String
    public let `extension`: String
    
    public var absoluteURL: URL? {
        URL(string: path + "." + `extension`)
    }
    
    public init(path: String, `extension`: String) {
        self.path = path
        self.`extension` = `extension`
    }
}
