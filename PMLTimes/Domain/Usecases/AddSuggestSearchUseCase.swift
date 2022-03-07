//
//  AddSuggestSearchUseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import RxSwift
import FirebaseFirestore

public protocol AddSuggestSearchUseCase {
    func execute(query: [String], completion: @escaping ((Error?)-> Void))
}

final class AddSuggestSearchUseCaseImpl: AddSuggestSearchUseCase {
    private var repo: FirestoreRepository
    
    init(repo: FirestoreRepository = FirestoreRepositoryImpl()) {
        self.repo = repo
    }
    
    public func execute(query: [String], completion: @escaping ((Error?)-> Void)) {
        repo.addSuggestSearch(query: query, completion: { error in
            completion(error)
        })
    }
    
}


