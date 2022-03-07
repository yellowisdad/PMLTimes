//
//  CustomDateTransform.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import ObjectMapper

open class CustomDateTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    let dateFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    public init() { }
    
    func setDateFormatter() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en-US")
        
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateTimeFormatter.locale = Locale(identifier: "en-US")
    }
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeStr = value as? String {
            setDateFormatter()
            if let date = dateFormatter.date(from: timeStr) {
                return date
            } else if let date = dateTimeFormatter.date(from: timeStr) {
                return date
            } else {
                return nil
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

