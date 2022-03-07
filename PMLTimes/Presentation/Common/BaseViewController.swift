//
//  BaseViewController.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit

class BaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Check view has destroy
    deinit {
        print("deinit: \(Self.self)")
    }
}
