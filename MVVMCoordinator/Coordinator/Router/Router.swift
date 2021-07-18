//
//  File.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/14.
//

import UIKit




final class Router: NSObject, RouterProtocol {
    
    private weak var rootNaviationController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?

    // MARK: - Private methods
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    // MARK: - Init methods
    
    init(rootController: UINavigationController) {
        self.rootNaviationController = rootController
        self.completions = [:]
        super.init()
        self.rootNaviationController?.delegate = self
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootNaviationController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
        self.transition = transition
        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        self.rootNaviationController?.pushViewController(controller, animated: animated)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.transition = transition
        if let controller = rootNaviationController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        self.rootNaviationController?.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootNaviationController?.setViewControllers([controller], animated: false)
        self.rootNaviationController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = self.rootNaviationController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }
    
    func popToModule(module: Presentable?, animated: Bool) {
        if let controllers = self.rootNaviationController?.viewControllers , let module = module {
            for controller in controllers {
                if controller == module as! UIViewController {
                    self.rootNaviationController?.popToViewController(controller, animated: animated)
                    break
                }
            }
        }
    }
    
    func toPresent() -> UIViewController? {
        self.rootNaviationController
    }
    
}

extension Router: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
    
}
