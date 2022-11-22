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
    
    // MARK: - Functions
    /**
    싱글톤 객체 ToDoManager에 저장되어 있는 **todos** 목록을 Update합니다.
    ㄴㅇㄹ
    */
    
    /// id키를 사용하여 로컬 todos에서 수정하고자 하는 값을 찾습니다.
    /// 해당하는 값이 있다면
    func editToDo(_ newToDo: ToDo) {
        ToDoManager.shared.todos.enumerated().forEach { (idx, searchedToDo) in
            if searchedToDo.id == newToDo.id { // found todo data to edit
                ToDoManager.shared.todos.replace(at: idx, with: newToDo)
                ToDoManager.shared.update(newToDo)
            }
        }
    }
    
    func toggleToDo(of todo: ToDo) {
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
        self.editToDo(newToDo)
    }
    
    func removeToDo(_ removingToDo: ToDo) {
        ToDoManager.shared.todos.enumerated().forEach { (index, todo) in
            if todo.id == removingToDo.id {
                ToDoManager.shared.todos.remove(at: index)
                ToDoManager.shared.delete(removingToDo)
            }
        }
    }
}

// MARK: - Private Functions
private extension ToDoViewModel {
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
