//
//  FirestoreRepository.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import RxSwift
import FirebaseFirestore



public protocol FirestoreRepository {
    func getSuggestSearch(completion: @escaping (([String: Any]?, Error?) -> Void))
    func addSuggestSearch(query: [String], completion: @escaping ((Error?) -> Void))
    func auth(completion: @escaping (([String: Any]?, Error?) -> Void))
}

final class FirestoreRepositoryImpl : FirestoreRepository {
    
    fileprivate var db = Firestore.firestore()
    fileprivate var document: String
    
    
    init() {
        
        var isRunningUnitTests: Bool {
            let env = ProcessInfo.processInfo.environment
            if let injectBundle = env["isRunningTest"] {
                return injectBundle == "enable"
            }
            return false
        }
        self.document = isRunningUnitTests ? "test-search" : "search"
    }
    
    func getSuggestSearch(completion: @escaping (([String: Any]?, Error?)-> Void)) {
        db.collection("pmlTimes").document(document)
            .addSnapshotListener { documentSnapshot, error in
                completion(documentSnapshot?.data(), error)
            }
    }
    
    func addSuggestSearch(query: [String], completion: @escaping ((Error?)-> Void)) {
        let document = db.collection("pmlTimes").document(document)
        document.updateData([
            "suggest-search": query
        ]) { error in
            completion(error)
        }
    }
    
    func auth(completion: @escaping (([String: Any]?, Error?)-> Void)) {
        db.collection("pmlTimes").document("auth")
            .addSnapshotListener { documentSnapshot, error in
                completion(documentSnapshot?.data(), error)
            }
    }
    
}
