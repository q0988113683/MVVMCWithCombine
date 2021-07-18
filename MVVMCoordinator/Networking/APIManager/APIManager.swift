//
//  APIManager.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/16.
//

import Foundation
public enum APIManagerSurrounding {
    case mock(MockURLSession)
}

public class APIManager: APIManagerProtocol {
    
    public static var shared: APIManager = APIManager()
    
    private lazy var networkController: NetworkControllerProtocol = {
        switch environment{
        case .mock(let mockSession):
            return NetworkController(session: mockSession)
        }
    }()
    
    public lazy var scheduleAPI: ScheduleAPIProtocol = {
        return ScheduleAPIController(networkController: self.networkController)
    }()
    
    fileprivate var environment: APIManagerSurrounding = .mock(MockURLSession(factory: ScheduleMockDataController()))
    
    init(surrounding: APIManagerSurrounding = .mock(MockURLSession(factory: ScheduleMockDataController()))) {
        self.environment = surrounding
    }
    
    
}
