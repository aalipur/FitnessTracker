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
}
