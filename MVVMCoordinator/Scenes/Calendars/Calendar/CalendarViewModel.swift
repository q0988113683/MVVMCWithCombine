//
//  File.swift
//  MVVMCoordinator
//
//  Created by Jhuo Yu cheng on 2021/7/15.
//

import Foundation
import Combine

class CalendarViewModel {
    
    @Published var schedule: [SpecificDay] = []
    @Published var isPreviousActionEnable = false
    @Published var isNextActionEnable = true
    
    fileprivate var time: ScheduleUrl = .file1 {
        didSet{
            isPreviousActionEnable = time != .file1
            isNextActionEnable = time != .file3
        }
    }
    fileprivate var subscriptions = Set<AnyCancellable>()
    
    init() {
        getSchedule(with: time)
    }
    
    private func getSchedule(with time: ScheduleUrl){
        
        let getScheduleCompletionHandler: (Subscribers.Completion<Error>) -> Void = { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                return
            }
        }
        
        let getScheduleHandler: (GetScheduleResponse) -> Void = { [weak self] response in
            guard let strongSelf = self else{
                return
            }
            if let available = response.available , let booked = response.booked {
                strongSelf.schedule = strongSelf.makeSchedule(available: available,
                                                   booked: booked)
            }
        }
        
        APIManager.shared.scheduleAPI.getSchedule(data: time)
            .sink(receiveCompletion: getScheduleCompletionHandler,
                  receiveValue: getScheduleHandler)
            .store(in: &subscriptions)
    }
    
    func getPreviousSchedule() {
        time = time.before()
        getSchedule(with: time)
    }
    
    func getNextSchedule() {
        time = time.next()
        getSchedule(with: time)
    }
}


extension CalendarViewModel{
    public func getNumberOfSections() -> Int{
        return schedule.count
    }
    public func getNumberOfItemsInSection(at index: Int) -> Int{
        return schedule[index].times?.count ?? 0
    }
    public func getSpecificDay(at index: Int) -> SpecificDay{
        return schedule[index]
    }
    public func getSpecificTime(at index: Int, section: Int) -> SpecificTime?{
        if let time = getSpecificDay(at: section).times{
            return time[index]
        }
        return nil
    }
}


extension CalendarViewModel{
    private func makeSchedule(available: [Schedule],
                              booked: [Schedule]) -> [SpecificDay]{
        
        typealias Tuple = (Date , [(Date, Bool)] )
        typealias TupleMap = [Date : [(Date, Bool)]]
        
        func makeSpecificTime( start: Date, end: Date,  isAvailable: Bool) -> [Tuple] {
            guard var date = start.onlyDate() else {
                fatalError()
            }
            var result: [Tuple] = []
            var start = start
            var time = [(Date, Bool)]()
            while end > start {
                time.append((start, isAvailable))
                start.addTimeInterval(30*60) // 30min
                if let newDate = start.onlyDate(),  date != newDate{
                    result.append((date, time))
                    date = newDate
                    time = []
                }
            }
            result.append((date, time))
            return result
        }
        
        func makeResult(items: [Schedule] , isAvailable: Bool ) -> TupleMap {
            var result: TupleMap = [:]
            items.forEach { (item) in
                let time = makeSpecificTime(start: item.start!,
                                            end: item.end!,
                                            isAvailable: isAvailable)
                time.forEach { triple in
                    if (result[triple.0] != nil) {
                        result[triple.0]!.append(contentsOf: triple.1)
                    }else{
                        result[triple.0] = triple.1
                    }
                }
            }
            return result
        }
        
        var availableResult = makeResult(items: available, isAvailable: true)
        let bookedResult    = makeResult(items: booked , isAvailable: false)
        availableResult.append(from: bookedResult)
        let keys = availableResult.keys.sorted()
        return Array(keys.map{
            SpecificDay(date: $0, times: availableResult[$0]!.sorted(by: { (lfs, rhs) -> Bool in
                lfs.0 < rhs.0
            }).map{
                SpecificTime(isAvailable: $1, time: $0)
            })
        }.prefix(7))
    }
}
