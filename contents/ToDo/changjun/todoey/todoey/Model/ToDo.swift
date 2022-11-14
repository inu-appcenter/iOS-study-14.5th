//
//  ToDo.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import Foundation

struct ToDo: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String
    var state: State
    var startDate: Date?
    var dueDate: Date?
    let created: Date
}

enum State: Codable {
    case notStarted
    case inProgress
    case completed
    case expired
}
