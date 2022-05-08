//
//  Date + Extensions.swift
//  FitnessTracker
//
//  Created by Анатолий Алипур on 15.04.2022.
//

import Foundation

extension Date {
    
    func getWeekDayNumber() -> Int {
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: self)
        return weekDay
    }
    
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) ?? Date()
        return localDate
    }
    
    func getWeekArray() -> [[String]] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "EEEEEE"
        
        var weekArray: [[String]] = [[], []]
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC") ?? .current
        
        for index in -6...0 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            
            let weekDay = formatter.string(from: date)
            weekArray[0].append(weekDay)
        }
        return weekArray
    }
    
    func offsetDay(days: Int) -> Date {
        let offsetDate = Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
        return offsetDate
    }
}
