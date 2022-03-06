//
//  SearchArticleUseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import RxSwift

final class SearchArticleUseCase: UseCase {
    private var nytRepository: NYTRepository!
    
    init(repo: NYTRepository = NYTRepositoryImpl()) {
        nytRepository = repo
    }
    
    public func execute(_ param: (query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)) -> Observable<[ArticleModel]> {
        return nytRepository.searchArticle(query: param.query, begin_date: param.begin_date, end_date: param.end_date, sort: param.sort, page: param.page)
            .flatMapLatest({ (response) -> Observable<[ArticleSearchModel]> in
                return Observable.just(response.results)
            })
            .flatMapLatest({ (response) -> Observable<[ArticleModel]> in
                return Observable.just(response.map { info in
                    return ArticleModel(_id: info.id,
                                        section: info.section,
                                        title: info.title,
                                        byline: info.byline,
                                        abstract: info.abstract,
                                        media: info.media.count > 0 ? [info.media[0]] : [],
                                        publishedDate: info.publishedDate,
                                        url: info.url)
                })
            })
    }
}


