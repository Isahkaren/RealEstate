//
//  SimpleAlert.swift
//  RealEstate
//
//  Created by Isabela Karen on 24/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import UIKit

class SimpleAlert {
    
    func showMessage(title: String, msg: String, on controller: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}

