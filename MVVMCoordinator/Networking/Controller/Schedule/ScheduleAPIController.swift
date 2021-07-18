//
//  ScheduleAPIController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
import Combine

public enum ScheduleUrl: Int , CaseIterable{
    case file1 = 1
    case file2
    case file3
}

public class ScheduleAPIController: BaseAPIController<ScheduleEndPoint> {
    
}

extension ScheduleAPIController: ScheduleAPIProtocol{
    public func getSchedule(data: ScheduleUrl) -> Future<GetScheduleResponse, Error> {
        
        return request(specificEndpoit: ScheduleEndPoint.schedule(url: "\(data)"), completionQueue: .main)
    }
}
