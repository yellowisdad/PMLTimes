//
//  NYTResponse.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import ObjectMapper

public class ArticleSearchResponse: Mappable {
    var status: String = ""
    var copyright: String = ""
    var results: [ArticleSearchModel] = []
    var error: [String] = []

    public init() {}
    required public init?(map: Map) { }

    public func mapping(map: Map) {
        status <- map["status"]
        copyright <- map["copyright"]
        results <- map["response.docs"]
        error <- map["error"]
    }
}

public class MostPopularResponse: Mappable {
    var status: String = ""
    var copyright: String = ""
    var results: [ArticleModel] = []
    var error: PMLTimesServiceError?

    public init() {}
    required public init?(map: Map) { }

    public func mapping(map: Map) {
        error <- map["fault"]
        status <- map["status"]
        copyright <- map["copyright"]
        results <- map["results"]
    }
}




