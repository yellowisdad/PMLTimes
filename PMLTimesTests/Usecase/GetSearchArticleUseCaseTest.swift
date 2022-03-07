//
//  GetSearchArticleUseCaseTest.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import XCTest
import RxSwift

@testable import PMLTimes
class GetSearchArticleUseCaseTest: XCTestCase {

    private var disposeBag = DisposeBag()

    func test_GetSearchArticleIsNotNil_ShouldSuccess() {
        let expectation = expectation(description: #function)
        let repo = NYTRepositorySpy()
        let expect = ArticleSearchResponse()
        repo.stubbedSearchArticleResult = .just(expect)
        
        let usecase = GetSearchArticleUseCaseImpl(repo: repo)
        usecase.execute(query: "test",
                        begin_date: "20220101",
                        end_date: "20220102",
                        sort: .newest, page: 0)
            .subscribe(onNext: { resp in
                expectation.fulfill()
                XCTAssertNotNil(resp)
                
            }, onError: { error in
                XCTFail()
            }).disposed(by: self.disposeBag)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
}
