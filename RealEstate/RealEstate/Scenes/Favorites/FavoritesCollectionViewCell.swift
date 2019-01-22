//
//  FavoritesCollectionViewCell.swift
//  RealEstate
//
//  Created by Isabela Karen on 22/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    //MARK - Properties
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    //MARK - LifeCycle
    
    func setup(item: Favorites) {
        titleLabel.text = item.title
        priceLabel.text = String(item.price)
        adressLabel.text = item.location
        favoriteImage.image = UIImage(named: "ic-image")
    }
}
