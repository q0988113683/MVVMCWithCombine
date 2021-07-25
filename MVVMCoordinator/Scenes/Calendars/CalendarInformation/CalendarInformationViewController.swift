//
//  CalendarInformation.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/17.
//

import UIKit
import Combine


protocol CalendarInformationViewControllerProtocol: class {
    var onBack: PassthroughSubject<Void, Never> { get set }
}

class CalendarInformationViewController: UIViewController, CalendarInformationViewControllerProtocol {
    
    var onBack = PassthroughSubject<Void, Never>()
    
    @IBOutlet weak var informationLabel: UILabel!
    
    var day: SpecificTime?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        informationLabel.text = day?.time.description
    }
    
    @IBAction func goBack(){
        self.onBack.send()
    }
}
