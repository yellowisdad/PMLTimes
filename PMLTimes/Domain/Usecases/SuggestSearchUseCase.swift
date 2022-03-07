//
//  SuggestSearchUseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import RxSwift
import FirebaseFirestore

final class SuggestSearchUseCase: UseCase {
    
    fileprivate var db = Firestore.firestore()
    init() {}
    
    public func execute(_ completion: @escaping (([String], Error?)->Void)) {
        db.collection("pmlTimes").document("b0Te2FroxTf2MIlRvWy1")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot,
                      let data = document.data(),
                      let suggest = data["suggest-search"] as? [String] else {
                          completion([], error)
                          return
                      }
                completion( suggest, error)
            }
    }
}

