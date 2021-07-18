//
//  GetScheduleResponse.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
public struct GetScheduleResponse: Decodable, ResponseType{
    let available: [Schedule]?
    let booked: [Schedule]?
    
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case booked = "booked"
    }
}
