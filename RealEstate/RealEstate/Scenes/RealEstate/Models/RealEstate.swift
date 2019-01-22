//
//  RealState.swift
//  RealEstate
//
//  Created by Isabela Karen on 22/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation

class RealEstate: Decodable {
    let id: Int
    let title: String
    let price: Double
    let location: Location
    let images: [Image]?
    
    init(id: Int, title: String, price: Double, location: Location, images: [Image]?) {
        self.id = id
        self.title = title
        self.price = price
        self.location = location
        self.images = images
    }
}
