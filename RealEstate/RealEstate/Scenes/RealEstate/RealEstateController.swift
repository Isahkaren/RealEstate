//
//  RealEstateViewModel.swift
//  RealEstate
//
//  Created by Isabela Karen on 22/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import CoreData

final class RealEstateController {
    
    //MARK - Properties
    
    private(set) var items = [RealEstate]()
    private let realEstateService: IRealEstateService
    
    weak var view: IRealEstateView?
    
    //MARK - Life Cycle
    
    init(realEstateService: IRealEstateService = RealEstateService()) {
        self.realEstateService = realEstateService
    }
    
    public func viewIsReady() {
        loadRealEstateList()
    }
    
    private func loadRealEstateList() {
        realEstateService.loadRealEstate { [weak self] (result) in
            guard let self = self else { return }
            
            self.items.removeAll()
            
            switch result {
            case .success(let realEstateList):
                self.insertAd(list: realEstateList.items)
            case .error(let error):
                self.view?.showAlert(message: error.description, title: "")
            }
        }
    }
    
    private func insertAd(list: [RealEstate]) {
        
        for (index, item) in list.enumerated() {
            if index % 2 == 0 && index > 0 {
                let location = Location(address: "", latitude: 1.0, longitude: 1.0)
                let ad = RealEstateAd(id: 1, title: "Scout24", price: 1.0, location: location, images: nil)
                items.append(ad)
            }
            
            items.append(item)
        }
        
        view?.reloadList()
    }
    
    //MARK - Persistence
    
    public func saveRealEstate(index: Int) {
        
        let selectedItem = items[index]
        
        guard let coreData = CoreDataStack.sharedInstance else {
            self.view?.showAlert(message: "Something is Wrong", title: "Ops")
            return
        }
        
        let favorite = Favorites(context: coreData.context)
        favorite.title = selectedItem.title
        favorite.price = selectedItem.price
        favorite.location = selectedItem.location.address
        
        DispatchQueue.main.async {
            self.view?.showAlert(message: "Favorite", title: "")
            CoreDataStack.sharedInstance?.save()
        }
    }
}
