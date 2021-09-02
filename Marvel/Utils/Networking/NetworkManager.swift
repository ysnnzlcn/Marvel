//
//  NetworkManager.swift
//  Marvel
//
//  Created by Yasin Nazlican on 31.08.2021.
//

import Foundation
import Alamofire

final public class NetworkManager {
    
    // MARK: Shared
    public static let shared = NetworkManager()
    
    // MARK: Life-Cycle
    private init() { }
    
    // MARK: Public Methods
    public func sendRequestWith<T: Decodable>(target: NetworkAPI, completion: @escaping ValueClosure<NetworkResult<T>>) {
        
        Session.default.request(target.url,
                                method: target.method,
                                parameters: target.parameters,
                                encoding: target.encoding,
                                headers: target.headers)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: { response in
                if let data = response.data {
                    if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(response: decodedResponse))
                    } else if let decodedError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(error: decodedError.statusMessage ?? "Encoding error."))
                    }
                } else {
                    completion(.failure(error: "No data found!"))
                }
            }
        )
    }
}
