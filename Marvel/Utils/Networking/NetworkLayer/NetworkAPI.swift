//
//  NetworkAPI.swift
//  Marvel
//
//  Created by Yasin Nazlican on 31.08.2021.
//

import Foundation
import Alamofire

public enum NetworkAPI {
    
    case getHeroes(_ request: GetHeroesRequest)
    case getComicsOfHero(_ heroId: Int, _ request: GetComicsRequest)
    
    private var baseURL: String {
        "https://gateway.marvel.com/v1/public/"
    }
    
    var url: String {
        var path = ""
        
        switch self {
        case .getHeroes:
            path = "characters"
            
        case .getComicsOfHero(let heroId, _):
            path = "characters/\(heroId)/comics"
        }
        
        return baseURL + path
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHeroes, .getComicsOfHero:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getHeroes(let request):
            return request.dict
            
        case .getComicsOfHero(_, let request):
            return request.dict
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.default
    }
}
