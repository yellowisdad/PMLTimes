//
//  SearchPageViewTest.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 8/3/2565 BE.
//

import XCTest
import UIKit
import RxSwift

@testable import PMLTimes
class SearchPageViewTest: XCTestCase {

    func test_SearchPageView_AssertNotNil() throws {
        let vm = SearchPageViewModel()
        let page = SearchPageView.create(with: vm)
        XCTAssertNotNil(page, "Error did not find view")
    }

}
