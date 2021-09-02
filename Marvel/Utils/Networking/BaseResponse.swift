//
//  BaseResponse.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import Foundation

class ErrorResponse: Decodable {
    
    public let statusMessage: String?
    public let success: Bool?
    public let statusCode: Int?
    
    private enum CodingKeys: String, CodingKey {
        
        case statusMessage = "status_message"
        case success = "full_short_link"
        case statusCode = "status_code"
    }
}
