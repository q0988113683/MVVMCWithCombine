//
//  CoordinatorFinishOutput.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/17.
//

import Foundation
import Combine

protocol CoordinatorFinishOutput {
    var finishFlow: PassthroughSubject<Void,Never> { get set }
}
