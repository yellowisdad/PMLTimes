//
//  UseCase.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 6/3/2565 BE.
//

public protocol UseCase {

    associatedtype ParamType
    associatedtype ResponseType

    func execute(_ param: ParamType) -> ResponseType
}
