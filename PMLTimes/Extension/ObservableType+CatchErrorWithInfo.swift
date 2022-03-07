//
//  ObservableType+CatchErrorWithInfo.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

import ObjectMapper
import Moya.Swift
import RxSwift

public extension ObservableType {
    
    func catchErrorWithInfo() -> Observable<Element> {
        return catchError({ (e) -> Observable<Element>  in
            guard let error = e as? Moya.MoyaError else { throw e }
            guard case .statusCode(let response) = error else { throw e }
            if let error = try Mapper<PMLTimesServiceError>().map(JSONObject: response.mapJSON()) {
                return Observable.error(error.toError(code: response.statusCode))
            } else {
                return Observable.error(error)
            }
        })
    }
    
}

public class PMLTimesServiceError: Mappable {
    var message: String?
    var errorcode: String?

    required public init?(map: Map) {
        guard (map.JSON["fault"] as? [String: Any]) != nil else {
            return nil
        }
    }

    public func mapping(map: Map) {
        message <- map["fault.faultstring"]
        errorcode <- map["fault.detail.errorcode"]
    }
    
    public func toError(code: Int) -> NSError {
        return NSError(domain: "ServiceErrorDomain", code: code, reason: errorcode ?? "", description: message ?? "")
    }
}

extension NSError {
    public convenience init(domain: String, code: Int) {
        self.init(domain: domain, code: code, userInfo: nil)
    }
    public convenience init(domain: String, code: Int, reason: String, description: String) {
        self.init(domain: domain, code: code, userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString(description, comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString(reason, comment: "")
            ])
    }
}
