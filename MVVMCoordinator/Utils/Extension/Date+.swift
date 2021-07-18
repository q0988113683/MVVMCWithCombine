

import Foundation


extension Date{
    func specificTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    func week() -> String{
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([ .weekday], from: self)
        return calendar.shortWeekdaySymbols[(dateComponents.weekday ?? 1) - 1]
    }
    func day() -> Int?{
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([ .day], from: self)
        return dateComponents.day
    }
    
    func onlyDate() -> Date?{
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            fatalError()
        }
        return date
    }
    
    func isEndNight() -> Bool {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([ .hour, .minute], from: self)
        return dateComponents.hour == 23 && dateComponents.minute == 30
    }
}
