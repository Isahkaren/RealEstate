//
//  RealEstateService.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation

protocol IRealEstateService {
    func loadRealEstate(completion: @escaping (HTTPResult<RealEstateList>) -> Void)
}

public final class RealEstateService: IRealEstateService {
    
    private let connector: Connector
    
    init(connector: Connector = Connector()) {
        self.connector = connector
    }
    
    func loadRealEstate(completion: @escaping (HTTPResult<RealEstateList>) -> Void) {
        let endpoint = RealEstateEndpoint()
        connector.response(from: endpoint, completion: completion)
    }
}
