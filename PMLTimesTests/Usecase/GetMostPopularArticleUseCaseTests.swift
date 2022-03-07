//
//  GetMostPopularArticleUseCaseTests.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import XCTest
import RxSwift

@testable import PMLTimes
class GetMostPopularArticleUseCaseTests: XCTestCase {
    
    private var disposeBag = DisposeBag()
    
    func test_GetMostPopularArticleByDayIsNotNil_ShouldSuccess() {
        let expectation = expectation(description: "test_GetMostPopularArticleIsNotNil_ShouldSuccess")
        let repo = NYTRepositorySpy()
        let expect = MostPopularResponse()
        repo.stubbedGetMostpopularResult = .just(expect)
        
        let usecase = GetMostPopularArticleUseCaseImpl(repo: repo)
        usecase.execute(.day)
            .subscribe(onNext: { resp in
                XCTAssertNotNil(resp)
                expectation.fulfill()
            }, onError: { error in
                XCTFail()
            }).disposed(by: self.disposeBag)
        
        wait(for: [expectation], timeout: 0.1)
    }
}
