//
//  MostPopularArticleUseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import RxSwift

final class MostPopularArticleUseCase: UseCase {
    private var nytRepository: NYTRepository!
    
    init(repo: NYTRepository = NYTRepositoryImpl()) {
        nytRepository = repo
    }
    
    public func execute(_ period: MostPopularPeriod) -> Observable<[ArticleModel]> {
        return nytRepository.getMostpopular(period: period)
            .flatMapLatest({ (response) -> Observable<[ArticleModel]> in
                return Observable.just(response.results)
            })
    }
}

