//
//  File.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/15.
//

import UIKit
class ViewControllerFactory {
    
    func instantiateCalendarViewController() -> CalendarViewController {
        let calendarVC = UIStoryboard.calendar.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        
        return calendarVC
    }
    
    func instantiateCalendarInformationViewController() -> CalendarInformationViewController {
        let calendarInformationVC = UIStoryboard.calendar.instantiateViewController(withIdentifier: "CalendarInformationViewController") as! CalendarInformationViewController
        return calendarInformationVC
    }
}
