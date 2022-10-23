//
//  ScheduleAPIProtocol.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine
public protocol ScheduleAPIProtocol{
    func getSchedule(from url: ScheduleUrl) -> AnyPublisher<GetScheduleResponse, Error>
}

