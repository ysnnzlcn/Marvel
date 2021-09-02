//
//  NetworkAPI.swift
//  Marvel
//
//  Created by Yasin Nazlican on 31.08.2021.
//

import Foundation
import Alamofire

public enum NetworkAPI {
    
    case getHeroes
    
    private var baseURL: String {
        ""
    }
    
    var url: String {
        var path = ""
        
        switch self {
        case .getHeroes:
            path = ""
        }
        
        return baseURL + path
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHeroes:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getHeroes:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.default
    }
}
