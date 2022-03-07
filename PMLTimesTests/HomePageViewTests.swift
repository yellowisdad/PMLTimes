//
//  HomePageViewTests.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 8/3/2565 BE.
//

import XCTest
import UIKit
import RxSwift

@testable import PMLTimes
class HomePageViewTests: XCTestCase {
    
    func test_HomePageView_AssertNotNil() throws {
        let vm = HomePageViewModel()
        let page = HomePageView.create(with: vm)
        XCTAssertNotNil(page, "Error did not find view")
    }

}
