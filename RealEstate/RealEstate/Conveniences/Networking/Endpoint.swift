//
//  Endpoint.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public protocol Endpoint {
    associatedtype ResponseType: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    
    var api: Environment.API { get }
    var decoder: JSONDecoder { get }
}

public extension Endpoint {
    
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
}

public extension Endpoint {
    
    func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = api.url.scheme
        urlComponents.host = api.url.host
        urlComponents.path = path
        
        guard let url = urlComponents.url else {
            throw EndpointError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
