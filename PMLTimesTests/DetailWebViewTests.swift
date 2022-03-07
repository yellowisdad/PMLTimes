//
//  DetailWebViewTests.swift
//  PMLTimesTests
//
//  Created by Methawee Punkaew on 8/3/2565 BE.
//

import XCTest
import UIKit
import RxSwift

@testable import PMLTimes
class DetailWebViewTests: XCTestCase {

    func test_DetailView_AssertNotNil() throws {
        let vm = DetailWebViewModel(strURL: "https://www.google.com/")
        let page = DetailWebView.create(with: vm)
        XCTAssertNotNil(page, "Error did not find view")
        //page.viewDidLoad()
    }

}
