//
//  GetSuggestSearchUseCaseTest.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import XCTest
import RxSwift
import FirebaseFirestore

@testable import PMLTimes
class GetSuggestSearchUseCaseTest: XCTestCase {

    func test_GetSuggestSearchIsNotNil_ShouldSuccess() {
        let expectation = expectation(description: #function)
        
        let usecase = GetSuggestSearchUseCaseImpl()
        usecase.execute { data, error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else {
                XCTAssertNotNil(data)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
