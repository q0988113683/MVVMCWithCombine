//
//  NetworkControllerProtocol.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine

public typealias ResponseCompletion<Value> = AnyPublisher<Value, Error> where Value: ResponseType

protocol NetworkControllerProtocol {
    associatedtype Value
    func request<Value>(endpoint: EndPointType) -> ResponseCompletion<Value>
}
