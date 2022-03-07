//
//  AppGlobal.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import UIKit
import FirebaseFirestore

class AppGlobal {
    static var shared = AppGlobal()
    var service: ServiceURL!
    var navigationController: UINavigationController?
    
    init(){}
}
