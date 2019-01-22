//
//  Favorites+CoreDataProperties.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//
//

import Foundation
import CoreData

extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var location: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
}
