//
//  Services.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import Foundation

public protocol Services {
    
    func getHeroes(
        request: GetHeroesRequest,
        completion: @escaping ValueClosure<NetworkResult<GetHeroesResponse>>
    )
    
    func getComicsOfHero(
        heroId: Int,
        request: GetComicsRequest,
        completion: @escaping ValueClosure<NetworkResult<GetComicsResponse>>
    )
}
