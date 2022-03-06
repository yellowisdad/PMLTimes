//
//  AppService.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation

class ServiceURL {
    private(set) var url: URL
    private(set) var key: String
    
    init (url: String, key: String = "") {
        self.url = URL(string: url)!
        self.key = key
    }
}
