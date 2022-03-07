//
//  ObjectMapper+Extension.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, context: context))
        }
    }

    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, context: context))
        }
    }

    func mapArray<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, atKeyPath: keyPath, context: context))
        }
    }
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObjectWithHeaderStatusCode<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObjectWithHeaderStatusCode(type, context: context))
        }
    }
}


// MARK: - ImmutableMappable
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    /// Maps data received from the signal into an object
    /// which implements the ImmutableMappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, context: context))
        }
    }

    /// Maps data received from the signal into an array of objects
    /// which implement the ImmutableMappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, context: context))
        }
    }

    /// Maps data received from the signal into an object
    /// which implements the ImmutableMappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, atKeyPath: keyPath, context: context))
        }
    }

    func mapObject<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, atKeyPath: keyPath, context: context))
        }
    }

    /// Maps data received from the signal into an array of objects
    /// which implement the ImmutableMappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, atKeyPath: keyPath, context: context))
        }
    }
}

public extension Response {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> [T] {
        guard let array = try mapJSON() as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath)) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: BaseMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> [T] {
        guard let array = (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObjectWithHeaderStatusCode<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        guard let json = try mapJSON() as? [String: Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        var jsonWithHeaderStatusCode = json
        jsonWithHeaderStatusCode.updateValue(self.response?.statusCode ?? 0, forKey: "header_status_code")
        
        guard let object = Mapper<T>(context: context).map(JSONObject: jsonWithHeaderStatusCode) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
}


// MARK: - ImmutableMappable

public extension Response {
    
    /// Maps data received from the signal into an object which implements the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        return try Mapper<T>(context: context).map(JSONObject: try mapJSON())
    }
    
    /// Maps data received from the signal into an array of objects which implement the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) throws -> [T] {
        guard let array = try mapJSON() as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return try Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
    /// Maps data received from the signal into an object which implements the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath)) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    /// Maps data received from the signal into an array of objects which implement the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String, context: MapContext? = nil) throws -> [T] {
        guard let array = (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return try Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
}
