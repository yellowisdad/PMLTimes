//
//  GetSuggestSearchUseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import RxSwift
import FirebaseFirestore

public protocol GetSuggestSearchUseCase {
    func execute(_ completion: @escaping (([String], Error?)->Void))
}

final class GetSuggestSearchUseCaseImpl: GetSuggestSearchUseCase {
    private var repo: FirestoreRepository
    
    init(repo: FirestoreRepository = FirestoreRepositoryImpl()) {
        self.repo = repo
    }
    
    public func execute(_ completion: @escaping (([String], Error?)->Void)) {
        repo.getSuggestSearch { data, error in
            completion(data?["suggest-search"] as? [String] ?? [] , error)
        }
    }
}

