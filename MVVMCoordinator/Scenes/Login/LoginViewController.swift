//
//  LoginViewController.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/25.
//

import UIKit
import Combine

protocol LoginViewControllerProtocol: class {
    var onLogin: PassthroughSubject<Void, Never> { get set }
}

class LoginViewController: UIViewController, LoginViewControllerProtocol {
    
    var onLogin = PassthroughSubject<Void, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(){
        self.onLogin.send()
    }
}
