//
//  File.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/14.
//

import UIKit

protocol RouterProtocol: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(transition: UIViewControllerAnimatedTransitioning?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)
}

extension RouterProtocol{
    func present(_ module: Presentable?){
        present(module, animated: true)
    }
    
    
    func push(_ module: Presentable?) {
        self.push(module, transition: nil)
    }
    
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.push(module, transition: transition, animated: true)
    }
    
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.push(module, transition: transition, animated: animated, completion: nil)
    }
    
    func popModule() {
        self.popModule(transition: nil)
    }
    
    func popModule(transition: UIViewControllerAnimatedTransitioning?) {
        self.popModule(transition: transition, animated: true)
    }
    
    func dismissModule() {
        self.dismissModule(animated: true, completion: nil)
    }
    
    func setRootModule(_ module: Presentable?) {
        self.setRootModule(module, hideBar: false)
    }
}
