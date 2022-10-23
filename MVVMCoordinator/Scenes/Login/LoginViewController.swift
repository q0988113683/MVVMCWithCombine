//
//  LoginViewController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/25.
//

import UIKit
import Combine

protocol LoginViewControllerDelegate {
    func LoginViewControllerDidClickLogin(viewController: LoginViewController)
}

class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(){
        self.delegate?.LoginViewControllerDidClickLogin(viewController: self)
    }
}
