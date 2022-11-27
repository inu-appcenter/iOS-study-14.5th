//
//  Date+Formatter.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

extension Date {
    var onlyDate: Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: dateComponents)!
    }
    
    func convert(to format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        return dateFormatter.string(from: self)
    }
    
    func toMotivateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        switch dateFormatter.string(from: self) {
        case TimeSlice.startOfDay.time..<TimeSlice.startOfMorning.time:
            return MotivateString.dawn.text
        case TimeSlice.startOfMorning.time..<TimeSlice.startOfNoon.time:
            return MotivateString.morning.text
        case TimeSlice.startOfNoon.time..<TimeSlice.startOfEvening.time:
            return MotivateString.noon.text
        case TimeSlice.startOfEvening.time..<TimeSlice.endOfDay.time:
            return MotivateString.evening.text
        default:
            return "Error"
        }
    }
}
