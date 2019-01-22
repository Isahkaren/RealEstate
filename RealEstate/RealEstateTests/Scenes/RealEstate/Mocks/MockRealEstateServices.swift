//
//  MockRealEstateServices.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 24/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import XCTest
@testable import RealEstate

class MockRealEstateServices: IRealEstateService {
    
    enum MockType {
        case success
        case error
    }
    
    private let mockType: MockType
    
    init(mockType: MockType) {
        self.mockType = mockType
    }
    
    var didCallrealEstate = false
    var titleUIID = UUID().uuidString

    func loadRealEstate(completion: @escaping (TypedResult<RealEstateList, NetworkingError>) -> Void) {
        didCallrealEstate = true

        if mockType == .success {
            
            let location = Location(address: "UnitTest", latitude: 1.0, longitude: 1.0)
            let realEstate = RealEstate(id: 999, title: titleUIID, price: 20, location: location, images: nil)
            let realEstate2 = RealEstate(id: 99, title: "UnitTest", price: 2, location: location, images: nil)
            let realEstate3 = RealEstate(id: 9, title: "ServiceMock", price: 200, location: location, images: nil)
            
            let data = RealEstateList(items: [realEstate, realEstate2, realEstate3])
            completion(.success(data))
        } else {
            completion(.error(NetworkingError(description: "some error")))
        }
    }
    
}
