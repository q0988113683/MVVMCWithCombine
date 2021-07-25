//
//  ViewControllerFactory+Login.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/26.
//

import UIKit
extension ViewControllerFactory {
    
    func instantiateLoginViewController() -> LoginViewController {
        let loginVC = UIStoryboard.login.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        return loginVC
    }

}
