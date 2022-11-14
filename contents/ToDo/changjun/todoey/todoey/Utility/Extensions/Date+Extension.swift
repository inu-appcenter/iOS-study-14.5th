//
//  Date+Extension.swift
//  todoey
//
//  Created by 이창준 on 2022/11/14.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
