//
//  File.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/15.
//

import Foundation
import Combine

final class CalendarCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    var finishFlow = PassthroughSubject<Void,Never>()
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    private var subscriptions = Set<AnyCancellable>()
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    override func start() {
        self.showCalendarViewController()
    }
    
    // MARK: - Private methods
    private func showCalendarViewController() {
        let viewModel = CalendarViewModel()
        
        let calendarVC = self.viewControllerFactory.instantiateCalendarViewController()
        
        calendarVC.viewModel = viewModel
        
        calendarVC.delegate = self
    
        self.router.setRootModule(calendarVC, hideBar: true)
    }
    
    private func showCalendarInformationViewController(withDay day: SpecificTime) {
        
        let calendarVC = self.viewControllerFactory.instantiateCalendarInformationViewController()
        calendarVC.day = day
        calendarVC.delegate = self
        self.router.push(calendarVC)
    }
}

extension CalendarCoordinator: CalendarViewControllerDelegate {
    func ViewController(viewController: CalendarViewController, didClickDay time: SpecificTime) {
        self.showCalendarInformationViewController(withDay: time)
    }
}

extension CalendarCoordinator: CalendarInformationViewControllerDelegate {
    func ViewControllerDidClickBack(viewController: CalendarInformationViewController) {
        self.router.popModule()
    }
}
