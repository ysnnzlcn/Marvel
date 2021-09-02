//
//  RestServices.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import Foundation

public struct RestServices: Services {

    public func getHeroes(
        request: GetHeroesRequest,
        completion: @escaping ValueClosure<NetworkResult<GetHeroesResponse>>
    ) {
        NetworkManager.shared.sendRequestWith(target: .getHeroes(request), completion: completion)
    }
    
    public func getComicsOfHero(
        heroId: Int,
        request: GetComicsRequest,
        completion: @escaping ValueClosure<NetworkResult<GetComicsResponse>>
    ) {
        NetworkManager.shared.sendRequestWith(target: .getComicsOfHero(heroId, request), completion: completion)
    }
}
