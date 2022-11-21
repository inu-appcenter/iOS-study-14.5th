//
//  Namings.swift
//  todoey
//
//  Created by 이창준 on 2022/11/08.
//

import UIKit

struct SF {
    enum Navigation {
        case menu
        
        var iconImage: UIImage? {
            switch self {
            case .menu:
                return UIImage(systemName: "line.3.horizontal")
            }
        }
    }
    
    enum CheckBox {
        case checked
        case unchecked
        
        var iconImage: UIImage? {
            switch self {
            case .checked:
                return UIImage(systemName: "checkmark.circle.fill")
            case .unchecked:
                return UIImage(systemName: "circle")
            }
        }
    }
}

struct TM {
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
}
