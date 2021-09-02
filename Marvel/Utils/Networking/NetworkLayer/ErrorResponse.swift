//
//  ErrorResponse.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import Foundation

class ErrorResponse: Decodable {

    public let code: String
    public let message: String
    
    public init(code: String, message: String) {
        self.code = code
        self.message = message
    }
}

