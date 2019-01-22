//
//  RealEstateEndpointTests.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 24/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import XCTest
@testable import RealEstate

class RealEstateEndpointTests: XCTestCase {
    
    var endpoint = RealEstateEndpoint()
    
    func test_init_shouldAssignCorrectPath() {
        XCTAssertEqual(endpoint.path, "/realestates")
    }
    
    func test_init_shouldAssignCorrectMethod() {
        XCTAssertEqual(endpoint.method, .get)
    }
    
    func test_init_shouldAssignCorrectAPI() {
        XCTAssertEqual(endpoint.api, .realEstate)
    }
}
