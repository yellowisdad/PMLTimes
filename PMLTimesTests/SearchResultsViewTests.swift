//
//  SearchResultsViewTests.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 8/3/2565 BE.
//

import XCTest
import UIKit
import RxSwift

@testable import PMLTimes
class SearchResultsViewTests: XCTestCase {

    func test_SearchResultsView_AssertNotNil() throws {
        let vm = SearchResultsViewModel(query: "test")
        let page = SearchResultsView.create(with: vm)
        XCTAssertNotNil(page, "Error did not find view")
    }

}
