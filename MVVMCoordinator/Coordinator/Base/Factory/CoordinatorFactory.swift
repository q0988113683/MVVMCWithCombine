//
//  CoordinatorFactory.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/15.
//

import Foundation


protocol CoordinatorFactoryProtocol {
    func makeCalendarCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> CalendarCoordinator
    
    func makeLoginCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> LoginCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    // MARK: - CoordinatorFactoryProtocol
    
    func makeCalendarCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> CalendarCoordinator {
        let coordinator = CalendarCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeLoginCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> LoginCoordinator {
        let coordinator = LoginCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
}
