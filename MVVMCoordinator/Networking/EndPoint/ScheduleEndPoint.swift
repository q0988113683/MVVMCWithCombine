//
//  ScheduleEndPoint.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
typealias EndPoint = EndPointType

public enum ScheduleEndPoint: EndPoint {
    case schedule(url: String)
}

extension ScheduleEndPoint {
    public var url: URL {
        switch self {
        case .schedule(let url):
            return URL(string: url)!
        }
    }
}
