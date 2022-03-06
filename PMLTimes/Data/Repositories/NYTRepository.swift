//
//  NYTRepository.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

public protocol NYTRepository {
    func getMostpopular(period: MostPopularPeriod) -> Observable<MostPopularResponse>
    func searchArticle(query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)-> Observable<ArticleSearchResponse>
}

final class NYTRepositoryImpl : NYTRepository {
    
    private var nytProvider = PMLTimesProvider<NYTimesAPI>()
    
    func getMostpopular(period: MostPopularPeriod)-> Observable<MostPopularResponse> {
        return nytProvider
            .rx.request(.mostpopular(period: period))
            .asObservable()
            .filter(statusCodes: 200...299)
            .mapObject(MostPopularResponse.self)
            .catchErrorWithInfo()
    }

    func searchArticle(query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)-> Observable<ArticleSearchResponse> {
        return nytProvider
            .rx.request(.articleSearch(query: query,
                                       begin_date: begin_date,
                                       end_date: end_date,
                                       sort: sort,
                                       page: page))
            .asObservable()
            .filter(statusCodes: 200...299)
            .mapObject(ArticleSearchResponse.self)
            .catchErrorWithInfo()
    }
    
    
    
}


