//
//  BaseAPIController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
public class BaseAPIController {
    var networkController: any NetworkControllerProtocol
    init(networkController: any NetworkControllerProtocol) {
        self.networkController = networkController
    }
}
