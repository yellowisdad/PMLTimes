//
//  GetMostPopularArticleUseCaseSpy.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import Foundation
import RxSwift

@testable import PMLTimes
final class GetMostPopularArticleUseCaseSpy: GetMostPopularArticleUseCase {

    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (period: MostPopularPeriod, Void)?
    var invokedExecuteParametersList = [(period: MostPopularPeriod, Void)]()
    var stubbedExecuteResult: Observable<[ArticleModel]>!

    func execute(_ period: MostPopularPeriod) -> Observable<[ArticleModel]> {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (period, ())
        invokedExecuteParametersList.append((period, ()))
        return stubbedExecuteResult
    }
}
