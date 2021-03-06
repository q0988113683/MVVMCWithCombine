//
//  ApplicationCoordinator.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/14.
//

import Foundation
import Combine

final class ApplicationCoordinator: BaseCoordinator {

    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private let viewControllerFactory: ViewControllerFactory = ViewControllerFactory()
    private var applicationInstructor = ApplicationInstructor.login
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        switch applicationInstructor {
        case .login:
            runLoginView()
        case .main:
            runCalendarView()
        }
        
    }
    
    // MARK: - Private methods
    
    private func runLoginView() {
        let coordinator = self.coordinatorFactory.makeLoginCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        coordinator.finishFlow.sink{ [unowned self, unowned coordinator] (_) in
            self.removeDependency(coordinator)
            self.applicationInstructor = .main
            self.start()
        }.store(in: &subscriptions)
            
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    
    private func runCalendarView() {
        let coordinator = self.coordinatorFactory.makeCalendarCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        
        coordinator.finishFlow.sink { [unowned self, unowned coordinator] (_) in
            self.removeDependency(coordinator)
            self.start()
        }.store(in: &subscriptions)
  
        self.addDependency(coordinator)
        coordinator.start()
    }
}
