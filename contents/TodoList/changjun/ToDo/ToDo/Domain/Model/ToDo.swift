//
//  ToDo.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/28.
//

import Foundation

struct ToDo: Codable, Identifiable {
    let id: Int
    let memberID: Int
    var title: String
    var description: String
    var state: State
    var dueDate: Date?
    let created: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "todoId"
        case memberID = "idOfMember"
        case title
        case description = "content"
        case state = "completed"
        case dueDate
        case created
    }
}
