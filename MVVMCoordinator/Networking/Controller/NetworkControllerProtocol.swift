//
//  NetworkControllerProtocol.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine
protocol NetworkControllerProtocol {
    func request(endpoint: EndPointType) -> Future<Data, Error>
}
