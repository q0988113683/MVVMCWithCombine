

import Foundation

extension Calendar{
    
    func getWeeksDate(from date :Date) -> [Date]? {
        var dates: [Date] = []
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        if  var day = dateComponents.day{
            for _ in 0 ... 6 {
                if let date = calendar.date(from: dateComponents){
                    dates.append(date)
                }
                day = day + 1
                dateComponents.day = day
            }
            return dates
        }
        return nil
    }
    
    func getThisWeeksDate() -> [Date]? {
        var dates: [Date] = []
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        if let week = dateComponents.weekday, let day = dateComponents.day{
            let diff = week == 1 ? 0 : week - 1
            for i in 0 ... 6 {
                let diff = i - diff
                dateComponents.day = day + diff
                if let date = calendar.date(from: dateComponents){
                    dates.append(date)
                }
            }
            return dates
        }
        return nil
    }
}
