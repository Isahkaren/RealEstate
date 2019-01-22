//
//  FavoritesView.swift
//  RealEstate
//
//  Created by Isabela Karen on 22/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import UIKit
import CoreData

protocol IFavoritesView: AnyObject {
    func reloadList()
    func showAlert(message: String, title: String)
}

class FavoritesView: UIViewController {
    
    //MARK - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: FavoritesController = FavoritesController()

    //MARK - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        view.addGestureRecognizer(longPressRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadStoredItems()
        
    }
    
    //MARK - GestureRecognizer
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.collectionView)
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                viewModel.deleteItem(index: indexPath.row)
            }
        }
    }
}

extension FavoritesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCellId", for: indexPath) as! FavoritesCollectionViewCell
        
        cell.setup(item: viewModel.items[indexPath.row])
        
        return cell
    }
}

extension FavoritesView: IFavoritesView {
    func reloadList() {
        collectionView.reloadData()
    }
    
    func showAlert(message: String, title: String) {
        SimpleAlert().showMessage(title: title, msg: message, on: self)
    }
}
