//
//  LoginCoordinator.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/25.
//

import Foundation
import Combine

final class LoginCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
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
        self.showLoginViewController()
    }
    
    // MARK: - Private methods
    private func showLoginViewController() {
        let loginVC = self.viewControllerFactory.instantiateLoginViewController()
        
        loginVC.onLogin.sink { [unowned self] in
            self.finishFlow.send()
        }.store(in: &subscriptions)
        
        self.router.setRootModule(loginVC, hideBar: true)
    }
}
