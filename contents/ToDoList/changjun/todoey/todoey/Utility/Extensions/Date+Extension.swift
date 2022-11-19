//
//  Date+Extension.swift
//  todoey
//
//  Created by 이창준 on 2022/11/14.
//

import Foundation

extension Date {
    var koreanTimeFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        return dateFormatter
    }
    
    func toString() -> String {
        koreanTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return koreanTimeFormatter.string(from: self)
    }
    
    func toMotivateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let timeSlice = TM.TimeSlice.self
        switch dateFormatter.string(from: self) {
        case timeSlice.startOfDay.time..<timeSlice.startOfMorning.time:
            return Motivate.dawn.motivateString
        case timeSlice.startOfMorning.time..<timeSlice.startOfNoon.time:
            return Motivate.morning.motivateString
        case timeSlice.startOfNoon.time..<timeSlice.startOfEvening.time:
            return Motivate.noon.motivateString
        case timeSlice.startOfEvening.time..<timeSlice.endOfDay.time:
            return Motivate.evening.motivateString
        default:
            return "Error"
        }
    }
}
