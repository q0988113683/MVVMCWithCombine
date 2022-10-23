//
//  CalendarInformation.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/17.
//

import UIKit
import Combine

protocol CalendarInformationViewControllerDelegate {
    func ViewControllerDidClickBack(viewController: CalendarInformationViewController)
}

class CalendarInformationViewController: UIViewController {
    
    @IBOutlet weak var informationLabel: UILabel!
    
    var day: SpecificTime?
    
    var delegate: CalendarInformationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        informationLabel.text = day?.time.description
    }
    
    @IBAction func goBack(){
        self.delegate?.ViewControllerDidClickBack(viewController: self)
    }
}
