//
//  APIControllerProtocol.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine


protocol APIControllerProtocol {
    var networkController: NetworkControllerProtocol { get }
    func request<T>(specificEndpoit: EndPointType, completionQueue: DispatchQueue)  ->  APIControllerPublisher<T> where T: ResponseType
}
