//
//  EditViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/14.
//

import Foundation

final class EditViewModel {
    
    // MARK: - Observables
    let isEdit: Observable<Bool> = Observable(false)
    let todoData: Observable<ToDo?> = Observable(nil)
    
    // MARK: - Functions
    func setIsEdit(_ isEdit: Bool) {
        self.isEdit.value = isEdit
    }
    
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
    
    func editToDo(
        _ inputTitleText: String,
        _ inputDescriptionText: String?,
        _ inputDueDate: Date
    ) {
        if let inputDescriptionText {
            self.todoData.value?.title = inputTitleText
            self.todoData.value?.description = inputDescriptionText
            self.todoData.value?.dueDate = inputDueDate

            ToDoManager.shared.todos.enumerated().forEach { (idx, searchedToDo) in
                if searchedToDo.id == self.todoData.value?.id { // found todo data to edit
                    ToDoManager.shared.todos[idx] = self.todoData.value!
                    ToDoManager.shared.update(self.todoData.value!)
                }
            }
        }
    }
}
