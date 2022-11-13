//
//  EditViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/14.
//

import Foundation

final class EditViewModel {
    func createToDo(_ text: String?) {
        if let text = text {
            let todo = ToDo(title: text, state: .notStarted, startDate: nil, dueDate: nil, created: Date.now)
            ToDoManager.shared.create(todo)
        }
    }
}
