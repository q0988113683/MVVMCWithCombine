

import Foundation
import Combine

class CalendarManager {
    
    @Published var currentDate: [Date] = [] {
        didSet{
            firstDate = currentDate.first
            lastDate = currentDate.last
            if let str = makeTimeRangeDescription(){
                timeRangeString = str
            }
        }
    }
    @Published var timeRangeString = ""
    
    
    private var firstDate: Date?
    private var lastDate: Date?
    
    init() {
        if let dates = Calendar.current.getThisWeeksDate(){
            currentDate = dates
        }
    }
    
    
    public func updatePreviousWeeksDay() {
        let currentCalendar = Calendar.current
        if let firstDate = firstDate,
           let newDate = currentCalendar.date(byAdding: .day, value: -7, to: firstDate),
           let newDates = currentCalendar.getWeeksDate(from: newDate){
            currentDate = newDates
        }
    }
    public func updateNextWeeksDay() {
        let currentCalendar = Calendar.current
        if let lastDate = lastDate,
           let newDate = currentCalendar.date(byAdding: .day, value: 1, to: lastDate),
           let newDates = currentCalendar.getWeeksDate(from: newDate){
            currentDate = newDates
        }
    }
    
}

//MARK: private
extension CalendarManager{
    private func makeTimeRangeDescription() -> String? {
        if let firstDate = firstDate,
           let lastDate = lastDate {
            let calendar = Calendar.current
            let firstDateCalendar =  calendar.dateComponents([.year, .month, .day, .weekday], from: firstDate)
            let lastDateCalendar =  calendar.dateComponents([.year, .month, .day, .weekday], from: lastDate)
            if let year = firstDateCalendar.year,
               let month = firstDateCalendar.month,
               let day = firstDateCalendar.day,
               let lastDay = lastDateCalendar.day{
                return "\(String(describing: year))/\(String(describing: month))/\(String(describing: day)) - \(String(describing: lastDay))"
            }
        }
        return nil
    }
}

