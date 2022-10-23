//
//  CalendarInformationCoordinator.swift
//  MVVMCoordinator
//
//  Created by Polo on 2022/10/23.
//

import Foundation
import Combine

final class CalendarInformationCoordinator: BaseCoordinator {
    
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    private var subscriptions = Set<AnyCancellable>()
    private var day: SpecificTime
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory, day: SpecificTime) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
        self.day = day
    }
    
    override func start() {
        self.showCalendarInformationViewController()
    }
    
    // MARK: - Private methods
    private func showCalendarInformationViewController() {
        let calendarInformationViewController = self.viewControllerFactory.instantiateCalendarInformationViewController()
        calendarInformationViewController.day = day
        calendarInformationViewController.delegate = self
        self.router.push(calendarInformationViewController)
    }
}


extension CalendarInformationCoordinator: CalendarInformationViewControllerDelegate {
    func ViewControllerDidClickBack(viewController: CalendarInformationViewController) {
        self.router.popModule()
    }
}
