//
//  URLSessionMocks.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 24/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation
@testable import RealEstate

struct MockDecodableResponse: Decodable {
    let name: String
    
    static var jsonData: Data {
        let json = "{\"name\": \"Mock\"}"
        return json.data(using: .utf8)!
    }
}

struct MockDecodableEndpoint: Endpoint {
    enum MockType {
        case success
        case invalidPath
    }
    
    typealias ResponseType = MockDecodableResponse
    var api: Environment.API = .realEstate
    var path: String = "/any"
    var method: HTTPMethod = .get
    
    init(mockType: MockType = .success) {
        if mockType == .invalidPath {
            path = "thisIsAnInvalidPath"
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() { }
}

class MockURLSession: URLSession {
    
    enum MockType {
        case success(data: Data)
        case someError
        case not200Family
    }
    
    let mockType: MockType
    var wasCalled: Bool = false
    
    init(mockType: MockType) {
        self.mockType = mockType
    }
    
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        wasCalled = true
        switch mockType {
        case .success(let mockData):
            let response = HTTPURLResponse(url: Environment.API.realEstate.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            completionHandler(mockData, response, nil)
        case .someError:
            completionHandler(nil, nil, NetworkingError(description: "mock"))
        case .not200Family:
            let response = HTTPURLResponse(url: Environment.API.realEstate.url,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)
            completionHandler(nil, response, nil)
        }
        
        return MockURLSessionDataTask()
    }
}
