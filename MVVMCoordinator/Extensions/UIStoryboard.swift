//
//  File.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/15.
//

import UIKit

extension UIStoryboard {
    
    // MARK: - Vars & Lets
    
    static var main: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    static var calendar: UIStoryboard {
        return UIStoryboard.init(name: "Calendar", bundle: nil)
    }
}
