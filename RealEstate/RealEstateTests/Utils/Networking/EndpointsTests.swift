//
//  EndpointsTests.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 24/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import XCTest
@testable import RealEstate

class EndpointsTests: XCTestCase {
    
    func test_request_shouldReturnValidURLRequest() {
        let endpoint = MockEndpoint()
        let request = try! endpoint.request()
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url, Environment.API.realEstate.url.appendingPathComponent("v1/mock"))
    }
}

struct MockDecodable: Decodable { }
struct MockEndpoint: Endpoint {
    typealias ResponseType = MockDecodable
    var path: String = "/v1/mock"
    var method: HTTPMethod = .get
    var api: Environment.API = .realEstate
}
