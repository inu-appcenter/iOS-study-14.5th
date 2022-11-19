//
//  EditViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/14.
//

import Foundation

final class EditViewModel {
    func createToDo(
        _ inputTitleText: String,
        _ inputDescriptionText: String?,
        _ inputDueDate: Date
    ) {
        if let inputDescriptionText {
            let todo = ToDo(
                title: inputTitleText,
                description: inputDescriptionText,
                state: .notStarted,
                startDate: Date.now,
                dueDate: inputDueDate,
                created: Date.now
            )
            ToDoManager.shared.create(todo)
        }
    }
}
