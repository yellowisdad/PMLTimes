//
//  AuthenticationUseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import RxSwift
import FirebaseFirestore

final class AuthenticationUseCase: UseCase {
    
    fileprivate var db = Firestore.firestore()
    
    init() {}
    
    public func execute(_ completion: @escaping ((ServiceURL?)->Void)) {
        db.collection("pmlTimes").document("JqmosZzfMPsa0UuSnoFx")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot,
                      let data = document.data(),
                      let key = data["api-key"],
                      let url = data["domain"] else {
                          completion(nil)
                          return
                      }
                completion(ServiceURL(url: url as? String ?? "",
                                      key: key as? String ?? "",
                                      imageDomain: data["image-domain"] as? String ?? ""))
            }
    }
}

