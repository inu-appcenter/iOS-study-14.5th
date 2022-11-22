//
//  Date+Formatter.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

extension Date {
    func convertTo(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
