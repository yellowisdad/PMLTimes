//
//  PMLTimesProvider.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

class PMLTimesProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    init(){
        let endpointClosure = { (target: Target) -> Endpoint in
            let url = target.baseURL.absoluteString + target.path
            
            let endpoint = Endpoint(url: url,
                                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                    method: target.method,
                                    task: target.task,
                                    httpHeaderFields: target.headers)
            return endpoint
        }
        let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
            do {
                var request: URLRequest = try endpoint.urlRequest()
                request.headers = .default
                request.timeoutInterval = 300.0
                request.cachePolicy = .reloadIgnoringLocalCacheData
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(error, nil)))
            }
        }
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: [])
    }
    
}
