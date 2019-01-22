//
//  RealEstateView.swift
//  RealEstate
//
//  Created by Isabela Karen on 22/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import UIKit

protocol IRealEstateView: AnyObject {
    func reloadList()
    func showAlert(message: String, title: String)
}

final class RealEstateView: UIViewController {
    
    //MARK - Properties
    
    @IBOutlet weak var tableView: UITableView!
    private var controller: RealEstateController = RealEstateController()
    
    //MARK - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        view.addGestureRecognizer(longPressRecognizer)
        
        controller.view = self
        controller.viewIsReady()
    }

    //MARK - GestureRecognizer
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                controller.saveRealEstate(index: indexPath.row)
            }
        }
    }
}

extension RealEstateView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let ad = controller.items[indexPath.row] as? RealEstateAd {
            let cell = tableView.dequeueReusableCell(withIdentifier: "advertisementCellIdentifier", for: indexPath) as! UITableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "realEstateCellIdentifier", for: indexPath) as! RealEstateTableViewCell
            cell.setup(value: controller.items[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}

    //MARK - IRealEstateView

extension RealEstateView: IRealEstateView {
    
    func showAlert(message: String, title: String) {
        SimpleAlert().showMessage(title: title, msg: message, on: self)
    }
    
    func reloadList() {
        tableView.reloadData()
    }
}
