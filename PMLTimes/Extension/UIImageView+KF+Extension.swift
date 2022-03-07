//
//  UIImageView+KF+Extension.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ strUrl: String){
        var options: KingfisherOptionsInfo = []
        options.append(contentsOf: [.scaleFactor(UIScreen.main.scale)])
        options.append(.transition(.fade(0.1)))
        
        if let url = URL(string: strUrl.range(of: "http") == nil ? AppGlobal.shared.service.imageDomain + strUrl : strUrl) {
            self.kf.setImage(with: url,
                                         placeholder: UIImage(named: "placeholder"),
                                         options: options)
        } else {
            self.image = UIImage(named: "placeholder")
        }
    }
}
