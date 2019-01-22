//
//  UIImage+DownloadImage.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    public func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async() {
                        self.image = UIImage(named: "ic-image")
                    }
                    return
            }
            
            DispatchQueue.main.async() {
                self.image = image
            }
            
        }.resume()
    }
    
    public func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
}
