//
//  ConnectorTests.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 24/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import XCTest
@testable import RealEstate

class ConnectorTests: XCTestCase {
    
    func test_response_shouldDecodeValidResponse() {
        let mockSession = MockURLSession(mockType: .success(data: MockDecodableResponse.jsonData))
        let connector = Connector(with: mockSession)
        
        connector.response(from: MockDecodableEndpoint()) { (response) in
            switch response {
            case .success(let object):
                XCTAssertEqual(object.name, "Mock")
            case .error:
                XCTFail("Success expected")
            }
        }
    }
    
    func test_response_shouldFailWhenErrorIsReturned() {
        let mockSession = MockURLSession(mockType: .someError)
        let connector = Connector(with: mockSession)
        
        connector.response(from: MockDecodableEndpoint()) { (response) in
            switch response {
            case .success:
                XCTFail("Error expected")
            case .error(let error):
                XCTAssertTrue(type(of: error) == NetworkingError.self)
            }
        }
    }
    
    func test_response_shouldFailForNot200FamilyStatusCode() {
        let mockSession = MockURLSession(mockType: .not200Family)
        let connector = Connector(with: mockSession)
        
        connector.response(from: MockDecodableEndpoint()) { (response) in
            switch response {
            case .success:
                XCTFail("Error expected")
            case .error(let error):
                XCTAssertTrue(type(of: error) == NetworkingError.self)
            }
        }
    }
    
    func test_response_shouldFailWhenDecodesFails() {
        let mockSession = MockURLSession(mockType: .success(data: "invalid".data(using: .utf8)!))
        let connector = Connector(with: mockSession)
        
        connector.response(from: MockDecodableEndpoint()) { (response) in
            switch response {
            case .success:
                XCTFail("Error expected")
            case .error(let error):
                XCTAssertTrue(type(of: error) == NetworkingError.self)
            }
        }
    }
    
    func test_response_shouldFailAndNotForwardInvalidRequests() {
        let mockSession = MockURLSession(mockType: .success(data: MockDecodableResponse.jsonData))
        let connector = Connector(with: mockSession)
        
        connector.response(from: MockDecodableEndpoint(mockType: .invalidPath)) { (response) in
            switch response {
            case .success:
                XCTFail("Error expected")
            case .error(let error):
                XCTAssertTrue(type(of: error) == NetworkingError.self)
            }
        }
        
        XCTAssertFalse(mockSession.wasCalled)
    }
}

