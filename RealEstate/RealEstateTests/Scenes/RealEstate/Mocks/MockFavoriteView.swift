//
//  MockFavoriteView.swift
//  RealEstateTests
//
//  Created by Isabela Karen on 25/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation
@testable import RealEstate

class MockFavoriteView: IFavoritesView {
    
    var message = ""
    var title = ""
    
    func reloadList() {
        
    }
    
    func showAlert(message: String, title: String) {
        self.message = message
        self.title = title
    }
}
