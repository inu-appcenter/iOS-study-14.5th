//
//  TimeSlice.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/28.
//

import Foundation

enum TimeSlice {
    case startOfDay, startOfMorning, startOfNoon, startOfEvening, endOfDay
    
    var time: String {
        switch self {
        case .startOfDay:
            return "00:00"
        case .startOfMorning:
            return "06:00"
        case .startOfNoon:
            return "12:00"
        case .startOfEvening:
            return "18:00"
        case .endOfDay:
            return "24:00"
        }
    }
}
