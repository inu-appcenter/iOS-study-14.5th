//
//  ToDo.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import Foundation

struct ToDo: Codable, Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let state: State
    let startDate: Date?
    let dueDate: Date?
    let created: Date
}

enum State: Codable {
    case notStarted
    case inProgress
    case completed
    case expired
}
