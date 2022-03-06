//
//  MostPopularPeriod.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import ObjectMapper

public enum MostPopularPeriod : String {
    
    case day = "1"
    case week = "7"
    case month = "30"
    
    var filterImage: UIImage? {
        switch self {
        case .day:
            return UIImage(named: "buton_cal_day")
        case .week:
            return UIImage(named: "buton_cal_week")
        case .month:
            return UIImage(named: "buton_cal_month")
        }
    }
}

public enum SearchSort : String {
    
    case newest = "newest"
    case oldest = "oldest"
    case relevance = "relevance"
    
}


