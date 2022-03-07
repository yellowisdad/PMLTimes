//
//  Date+Extension.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import UIKit

extension Date {
    
    public func customDateFormat(_ format: String) -> String {
        let calendar = Calendar(identifier: .gregorian)

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en-US")

        formatter.calendar = calendar
        return formatter.string(from: self)
    }
    
    public func addChangeDateTime(year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date! {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        var components = calendar.dateComponents([.year, .month, .weekday, .day, .hour, .minute, .second], from: self)
        components.timeZone = NSTimeZone.local
        components.year = components.year! + year
        components.month = components.month! + month
        components.day = components.day! + day
        components.hour = components.hour! + hour
        components.minute = components.minute! + minute
        components.second = components.second! + second
        return calendar.date(from: components)
    }
}
