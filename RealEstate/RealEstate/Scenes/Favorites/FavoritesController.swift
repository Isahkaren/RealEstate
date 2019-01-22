//
//  FavoritesViewModel.swift
//  RealEstate
//
//  Created by Isabela Karen on 22/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import CoreData

public final class FavoritesController {
    
    private(set) var items = [Favorites]()
    
    weak var view: IFavoritesView?
    
    public func loadStoredItems() {
        
        items.removeAll()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            let results = try CoreDataStack.sharedInstance?.context.fetch(fetchRequest)
            guard let parsedResult = results as? [Favorites] else {
                return
            }
            items.append(contentsOf: parsedResult)
            self.view?.reloadList()
        } catch {
            view?.showAlert(message: "Something is Wrong", title: "Ops")
            return
        }
    }
    
    public func deleteItem(index: Int) {
        let selectedItem = items[index]
        
        self.view?.showAlert(message: "No more Favorite", title: "")
        items.remove(at: index)
        CoreDataStack.sharedInstance?.context.delete(selectedItem)
        
        DispatchQueue.main.async {
            CoreDataStack.sharedInstance?.save()
        }
        self.view?.reloadList()
    }
}
