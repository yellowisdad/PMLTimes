//
//  AppService.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import ObjectMapper

public struct ServiceURL: Mappable {
    public var domain: String = ""
    public var imageDomain: String = ""
    public var key: String = ""
    public var url: URL {
        return URL(string: domain)!
    }
    
    public init() {}
    public init?(map: Map) { }
    
    mutating public func mapping(map: Map) {
        domain    <- map["domain"]
        imageDomain    <- map["image-domain"]
        key <- map["key"]
    }
}
