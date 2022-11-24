//
//  ToDoUseCase.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

final class ToDoUseCase {
    
    // MARK: - Initializer
    init() {
        
    }
    
    // MARK: - Functions
    func createToDo(_ newToDo: ToDo) {
        ToDoManager.shared.todos.append(newToDo)
    }
    
    func getToDo(at idx: Int) -> ToDo? {
        return ToDoManager.shared.todos[idx]
    }
    
    func updateToDo(_ newToDo: ToDo) {
        ToDoManager.shared.todos.enumerated().forEach { (idx, searchedToDo) in
            if searchedToDo.id == newToDo.id { // found todo data to edit
                ToDoManager.shared.todos.replace(at: idx, with: newToDo)
            }
        }
    }
    
    func toggleToDo(_ todo: ToDo) {
        var newToDo: ToDo = todo
        switch newToDo.state {
        case .expired:
            fallthrough
        case .inProgress:
            fallthrough
        case .notStarted:
            newToDo.state = .completed
        case .completed:
            newToDo.state = self.handleStateWithDate(of: newToDo)
        }
        self.updateToDo(newToDo)
    }
    
    func deleteToDo(_ removingToDo: ToDo) {
        ToDoManager.shared.delete(removingToDo)
    }
}

// MARK: - Private Functions
private extension ToDoUseCase {
    func handleStateWithDate(of todo: ToDo) -> State {
        if let due = todo.dueDate {
            if due < Date.now {
                return .expired
            } else {
                return .inProgress
            }
        }
        return .completed
    }
}
