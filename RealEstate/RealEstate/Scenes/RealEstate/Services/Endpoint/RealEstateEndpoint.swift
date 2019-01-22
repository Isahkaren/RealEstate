//
//  RealEstateEndpoint.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation

struct RealEstateEndpoint: Endpoint {
    typealias ResponseType = RealEstateList
    var api: Environment.API = .realEstate
    var path: String = "/realestates"
    var method: HTTPMethod = .get
}
