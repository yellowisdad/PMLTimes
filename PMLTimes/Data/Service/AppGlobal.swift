//
//  AppGlobal.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import UIKit
import FirebaseFirestore

class AppGlobal {
    static var shared = AppGlobal()
    var service: ServiceURL!
    var imageDamain: String = ""
    
    fileprivate var db = Firestore.firestore()
    
    var navigationController: UINavigationController?
    
    init(){}
    
    
    func fechFirestore(completion: @escaping ((Bool)->Void)) {
        db.collection("pmlTimes").document("JqmosZzfMPsa0UuSnoFx")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot,
                      let data = document.data(),
                      let key = data["api-key"],
                      let url = data["domain"] else {
                          completion(false)
                          return
                      }
                if let imageDomain = data["image-domain"] {
                    self.imageDamain = imageDomain as! String
                }
                self.service = ServiceURL(url: url as! String, key: key as! String)
                completion(true)
            }
    }
}
