//
//  GetSearchArticleUseCaseSpy.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import RxSwift

@testable import PMLTimes
final class GetSearchArticleUseCaseSpy: GetSearchArticleUseCase {

    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)?
    var invokedExecuteParametersList = [(query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)]()
    var stubbedExecuteResult: Observable<[ArticleModel]>!

    func execute(query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int) -> Observable<[ArticleModel]> {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (query, begin_date, end_date, sort, page)
        invokedExecuteParametersList.append((query, begin_date, end_date, sort, page))
        return stubbedExecuteResult
    }
}
