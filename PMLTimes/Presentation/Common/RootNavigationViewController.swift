//
//  RootNavigationViewController.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import UIKit

class RootNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        AppGlobal.shared.navigationController = self
    }
}
