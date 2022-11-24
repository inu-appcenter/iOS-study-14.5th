//
//  ToDoViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

final class ToDoViewModel {
    
    // MARK: - Properties
    let todoUseCase: ToDoUseCase
    
    // MARK: - Initializer
    init(todoUseCase: ToDoUseCase) {
        self.todoUseCase = todoUseCase
    }
    
    // MARK: - Observables
    
    // MARK: - Functions
    /// .get, .read 구현 안됨
    func todoRequest(method: ToDoMethod, with data: ToDo?) {
        guard let todo = data else { return }
        switch method {
        case .create:
            self.todoUseCase.createToDo(todo)
        case .get:
            break
        case .read:
            break
        case .update:
            self.todoUseCase.updateToDo(todo)
        case .toggle:
            self.todoUseCase.toggleToDo(todo)
        case .delete:
            self.todoUseCase.deleteToDo(todo)
        }
    }
}
