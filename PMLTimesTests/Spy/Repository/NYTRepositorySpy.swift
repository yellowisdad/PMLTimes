//
//  NYTRepositorySpy.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

@testable import PMLTimes
final class NYTRepositorySpy: NYTRepository {

    var invokedGetMostpopular = false
    var invokedGetMostpopularCount = 0
    var invokedGetMostpopularParameters: (period: MostPopularPeriod, Void)?
    var invokedGetMostpopularParametersList = [(period: MostPopularPeriod, Void)]()
    var stubbedGetMostpopularResult: Observable<MostPopularResponse>!

    func getMostpopular(period: MostPopularPeriod) -> Observable<MostPopularResponse> {
        invokedGetMostpopular = true
        invokedGetMostpopularCount += 1
        invokedGetMostpopularParameters = (period, ())
        invokedGetMostpopularParametersList.append((period, ()))
        return stubbedGetMostpopularResult
    }

    var invokedSearchArticle = false
    var invokedSearchArticleCount = 0
    var invokedSearchArticleParameters: (query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)?
    var invokedSearchArticleParametersList = [(query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)]()
    var stubbedSearchArticleResult: Observable<ArticleSearchResponse>!

    func searchArticle(query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)-> Observable<ArticleSearchResponse> {
        invokedSearchArticle = true
        invokedSearchArticleCount += 1
        invokedSearchArticleParameters = (query, begin_date, end_date, sort, page)
        invokedSearchArticleParametersList.append((query, begin_date, end_date, sort, page))
        return stubbedSearchArticleResult
    }
}

