//
//  FavoriteEstateTests.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 25/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import XCTest
import CoreData

@testable import RealEstate
class FavoriteEstateTests: XCTestCase {
    
    var controller: FavoritesController!
    var view: MockFavoriteView!
    
    
    override func setUp() {
        controller = FavoritesController()
        view = MockFavoriteView()
        controller.view = view
    }

    func test_deleteItem_SholdDelete() {
        
        let favorite = Favorites(context: CoreDataStack.sharedInstance!.context)
        favorite.title = UUID().uuidString
        favorite.price = 0
        favorite.location = ""
        
        CoreDataStack.sharedInstance?.save()
        
        controller.loadStoredItems()
        
        let index = controller.items.count - 1
        controller.deleteItem(index: index)
        
        CoreDataStack.sharedInstance?.save()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        let results = try! CoreDataStack.sharedInstance?.context.fetch(fetchRequest) as! [Favorites]

        let item = results.filter { $0.title ==  favorite.title }.first
        
        XCTAssertNil(item)
    }
}
