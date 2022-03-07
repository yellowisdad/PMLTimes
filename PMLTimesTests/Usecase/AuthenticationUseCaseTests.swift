//
//  AuthenticationUseCaseTests.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 8/3/2565 BE.
//

import XCTest
import RxSwift
import FirebaseFirestore

@testable import PMLTimes

class AuthenticationUseCaseTests: XCTestCase {

    func test_AuthenIsNotNil_ShouldSuccess() {
        let expectation = expectation(description: #function)
        let usecase = AuthenticationUseCaseImpl()
        usecase.execute() { data, error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }  else {
                XCTAssertNotNil(data)
            }

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
