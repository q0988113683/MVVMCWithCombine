

import Foundation
public class ScheduleMockDataController: MockDataProtocol {
    
    public func fetchData(url: String) -> Data? {
        switch url {
        case let str where str.contains("\(ScheduleUrl.file1.rawValue)"):
            let path = Bundle.main.path(forResource: "schedule1", ofType: "json")!
            return FileManager.default.contents(atPath: path)
        case let str where str.contains("\(ScheduleUrl.file2.rawValue)"):
            let path = Bundle.main.path(forResource: "schedule2", ofType: "json")!
            return FileManager.default.contents(atPath: path)
        case let str where str.contains("\(ScheduleUrl.file3.rawValue)"):
            let path = Bundle.main.path(forResource: "schedule3", ofType: "json")!
            return FileManager.default.contents(atPath: path)
        default:
            return nil
        }
    }
}
