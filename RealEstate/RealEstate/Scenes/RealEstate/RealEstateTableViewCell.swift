//
//  RealEstateTableViewCell.swift
//  RealEstate
//
//  Created by Isabela Karen on 22/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import UIKit

class RealEstateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var realEstateImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(value: RealEstate) {
        titleLabel.text = value.title
        adressLabel.text = value.location.address
        priceLabel.text = String(value.price)
        
        guard let imageRE = value.images else {
            realEstateImage.image = UIImage(named: "ic-image")
            return
        }
        realEstateImage.download(from: imageRE[0].url)
    }
}
