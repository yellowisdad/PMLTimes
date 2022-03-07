//
//  FilterPageViewTests.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 8/3/2565 BE.
//

import XCTest
import UIKit
import RxSwift

@testable import PMLTimes
class FilterPageViewTests: XCTestCase {

    func test_FilterPageView_AssertNotNil() throws {
        let vm = FilterPageViewModel(beginDate: Date(), endDate: Date(), sort: .newest)
        let page = FilterPageView.create(with: vm)
        XCTAssertNotNil(page, "Error did not find view")
    }

}
