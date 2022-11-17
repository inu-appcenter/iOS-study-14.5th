//
//  ToDoListModel.swift
//  TodoList
//
//  Created by 정지훈 on 2022/11/11.
//

import Foundation
struct ToDoListModel : Codable {
    let title: String
    let day: String
    let text: String
    
    init(title: String, text: String, day: String) {
        self.title = title
        self.text = text
        self.day = day
    }
}

