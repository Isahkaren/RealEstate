//
//  Connector.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation

open class Connector {
    
    private let urlSession: URLSession
    
    init(with urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    open func response<T: Endpoint>(from endpoint: T,
                                    completion: @escaping (HTTPResult<T.ResponseType>) -> Void) {
        
        guard let request = try? endpoint.request() else {
            completion(.error(NetworkingError.genericError))
            return
        }
        
        let task = urlSession.dataTask(with: request) { (data, urlResponse, error) in
            let result: HTTPResult<T.ResponseType>
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard error == nil,
                let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
                (200..<299) ~= statusCode,
                let data = data
                else {
                    result = .error(NetworkingError.genericError)
                    return
            }
            
            do {
                let responseObject = try endpoint.decoder.decode(T.ResponseType.self, from: data)
                result = (.success(responseObject))
            } catch (let parserError) {
                debugPrint(parserError.localizedDescription)
                result = (.error(NetworkingError.genericError))
            }
        }
        
        task.resume()
    }
}

fileprivate extension NetworkingError {
    static var genericError: NetworkingError {
        return NetworkingError(description: "Something went wrong. Try again later.")
    }
}
