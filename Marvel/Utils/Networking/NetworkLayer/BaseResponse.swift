//
//  BaseResponse.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import Foundation

class BaseResponse<T: Decodable>: Decodable {

    public let status: String
    public let code: Int
    public let data: T?
    
    public var isSuccess: Bool {
        status == "Ok"
    }
    
    public init(status: String, code: Int) {
        self.status = status
        self.code = code
        self.data = nil
    }
}
