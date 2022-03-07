//
//  ArticleModel.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import ObjectMapper

public struct ArticleModel: Mappable {
    public var id: Int = 0
    public var _id: String = ""
    public var section: String = ""
    public var title: String = ""
    public var byline: String = ""
    public var abstract: String = ""
    public var media: [MediaMetadataModel] = []
    public var publishedDate: Date?
    public var url: String = ""

    public init() {}
    public init?(map: Map) { }
    
    mutating public func mapping(map: Map) {
        url    <- map["url"]
        id    <- map["id"]
        section <- map["section"]
        title    <- map["title"]
        byline    <- map["byline"]
        abstract    <- map["abstract"]
        media    <- map["media.0.media-metadata"]
        publishedDate <- (map["published_date"], CustomDateTransform())
    }
    
    init(id: Int = 0, _id: String = "", section: String, title: String, byline: String, abstract: String, media: [MediaMetadataModel], publishedDate: Date?, url: String){
        self.id = id
        self._id = _id
        self.section = section
        self.title = title
        self.byline = byline
        self.abstract = abstract
        self.media = media
        self.publishedDate = publishedDate
        self.url = url
    }
}

public struct MediaMetadataModel: Mappable {
    public var url: String = ""
    public var format: String = ""
    public var height: Int = 0
    public var width: Int = 0

    public init?(map: Map) { }
    mutating public func mapping(map: Map) {
        url    <- map["url"]
        format <- map["format"]
        width    <- map["width"]
        height    <- map["height"]
    }
}
