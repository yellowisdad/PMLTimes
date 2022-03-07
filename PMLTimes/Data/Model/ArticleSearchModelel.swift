//
//  ArticleSearchModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import ObjectMapper

public struct ArticleSearchModel: Mappable {
    public var id: String = ""
    public var section: String = ""
    public var title: String = ""
    public var byline: String = ""
    public var abstract: String = ""
    public var media: [MediaMetadataModel] = []
    public var publishedDate: Date?
    public var url: String = ""

    public init?(map: Map) { }
    mutating public func mapping(map: Map) {
        url    <- map["web_url"]
        id    <- map["id"]
        section <- map["section_name"]
        title    <- map["headline.main"]
        byline    <- map["byline.original"]
        abstract    <- map["abstract"]
        media    <- map["multimedia"]
        publishedDate <- (map["pub_date"], CustomDateTransform())
    }
}
