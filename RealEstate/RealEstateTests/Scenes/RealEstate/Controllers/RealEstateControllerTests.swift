//
//  RealEstateViewModelTests.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 24/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import XCTest
import CoreData
@testable import RealEstate

class RealEstateViewModelTests: XCTestCase {
    
    var controller: RealEstateController!
    var mockRealEstateServices: MockRealEstateServices!
    var view: MockRealEstateView!
    
    override func setUp() {
        mockRealEstateServices = MockRealEstateServices(mockType: .success)
        controller = RealEstateController(realEstateService: mockRealEstateServices)
        view = MockRealEstateView()
        controller.view = view
    }
    
    func test_viewIsReady_ShouldCallService() {
        controller.viewIsReady()
        
        XCTAssertTrue(mockRealEstateServices.didCallrealEstate)
    }
    
    func test_saveRealEstate_ShouldSave() {

        controller.viewIsReady()
        controller.saveRealEstate(index: 0)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        let results = try! CoreDataStack.sharedInstance?.context.fetch(fetchRequest) as! [Favorites]

        let savedItem = results.filter { $0.title ==  mockRealEstateServices.titleUIID }.first
        
        XCTAssertNotNil(savedItem)
    }
    
    func test_loadRealEstateList_ShouldFillItemsOnSuccess() {
        controller.viewIsReady()
        
        XCTAssertEqual(controller.items.count, 4)
    }
    
    func test_insertAd_SholdInsertAdInTheThirdPosition() {
        
        controller.viewIsReady()

        let ad = controller.items[2].title
        
        XCTAssertEqual(ad, "Scout24")
    }
}
