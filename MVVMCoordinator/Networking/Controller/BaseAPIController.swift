//
//  BaseAPIController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
public class BaseAPIController<EndPoint>: APIControllerProtocol where EndPoint: EndPointType {
    var networkController: NetworkControllerProtocol
    init(networkController: NetworkControllerProtocol) {
        self.networkController = networkController
    }
}
