//
//  NYTimesAPI.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import Moya

public enum NYTimesAPI {
    case articleSearch(query: String, begin_date: String, end_date: String, sort: SearchSort, page: Int)
    case mostpopular(period: MostPopularPeriod)
}

extension NYTimesAPI: TargetType {

    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    public var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }

    public var baseURL: URL { return AppGlobal.shared.service.url }

    public var path: String {
        switch self {
        case .mostpopular(let period):
            return "/mostpopular/v2/viewed/\(period.rawValue).json?api-key=\(AppGlobal.shared.service.key)"
        case .articleSearch(let query, let begin_date, let end_date, let sort, let page):
            return "/search/v2/articlesearch.json?q=\(query)&api-key=\(AppGlobal.shared.service.key)&begin_date=\(begin_date)&end_date=\(end_date)&sort=\(sort.rawValue)&page=\(page)"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return nil
    }

    public var sampleData: Data {
        return Data()
    }
}
