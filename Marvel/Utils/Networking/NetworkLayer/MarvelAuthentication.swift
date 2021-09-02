//
//  MarvelAuthentication.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation
import CryptoKit

public struct MarvelAuthentication {
    
    private static let publicKey = MarvelKey.`public`.rawValue
    private static let privateKey = MarvelKey.`private`.rawValue
    
    private static func md5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    public static func urlParameters() -> [String: String] {
        let time = timestamp
        let hash = md5(string: time + privateKey + publicKey)
        return ["ts": time,
                "apikey": publicKey,
                "hash": hash]
    }
    
    private static var timestamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSSSS'Z'"
        return dateFormatter.string(from: Date())
    }
}

public enum MarvelKey: String {
    
    case `public` = "e745558472cb431f77ac29a241b87122"
    case `private` = "cf994b03c8f542a63af855acd1402ee972d5019b" // I know this shouldn't be saved in the code for security purposes but since this is just a demo project, i will leave it like this.
}
