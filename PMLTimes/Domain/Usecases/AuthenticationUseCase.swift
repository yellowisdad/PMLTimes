//
//  AuthenticationUseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import RxSwift
import FirebaseFirestore

public protocol AuthenticationUseCase {
    func execute(_ completion: @escaping ((ServiceURL?, Error?) ->Void))
}

final class AuthenticationUseCaseImpl: AuthenticationUseCase {
    private var repo: FirestoreRepository
    
    init(repo: FirestoreRepository = FirestoreRepositoryImpl()) {
        self.repo = repo
    }
    
    public func execute(_ completion: @escaping ((ServiceURL?, Error?) ->Void)) {
        repo.auth { data, error in
            var service: ServiceURL? {
                guard let json = data?["data"] as? [String : Any] else { return nil }
                return ServiceURL(JSON: json)!
            }
            completion(service, error)
        }
    }
    
}

