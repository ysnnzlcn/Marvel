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
        let params = addDefaultParams(to: target.parameters)
        
        Session.default.request(target.url,
                                method: target.method,
                                parameters: params,
                                encoding: target.encoding,
                                headers: target.headers)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: { response in
                if let data = response.data {
                        if let baseResponse = try? JSONDecoder().decode(BaseResponse<T>.self, from: data) {
                            if let data = baseResponse.data, baseResponse.isSuccess {
                                completion(.success(response: data))
                            } else {
                                completion(.failure(error: baseResponse.status))
                            }
                        } else if let decodedError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            completion(.failure(error: decodedError.message))
                        } else {
                            print("Encoding error!")
                            completion(.failure(error: "Unexpected Data!"))
                        }
                } else {
                    completion(.failure(error: "Server error!"))
                }
            }
        )
    }
    
    private func addDefaultParams(to params: [String: Any]?) -> [String: Any] {
        var params = params ?? [:]
        MarvelAuthentication.urlParameters().forEach {
            params[$0.key] = $0.value
        }
        return params
    }
}
