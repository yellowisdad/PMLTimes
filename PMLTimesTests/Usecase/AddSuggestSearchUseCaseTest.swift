//
//  AddSuggestSearchUseCaseTest.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import XCTest
import RxSwift
import FirebaseFirestore

@testable import PMLTimes

class AddSuggestSearchUseCaseTest: XCTestCase {

    func test_AddSuggestSearchIsNotNil_ShouldSuccess() {
        let expectation = expectation(description: #function)
        let usecase = AddSuggestSearchUseCaseImpl()
        usecase.execute(query: ["test"]) { error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
