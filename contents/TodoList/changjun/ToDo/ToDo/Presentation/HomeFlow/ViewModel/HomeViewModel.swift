//
//  HomeViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Properties
    weak var coordinator: HomeCoordinator?
    let homeUseCase: HomeUseCase
    
    // MARK: - Observables
    let todoProgress: Observable<Int> = Observable(0)
    
    // MARK: - Initializer
    init(coordinator: HomeCoordinator, homeUseCase: HomeUseCase) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
    // MARK: - Input
    
    
    // MARK: - Functions
    func todoUpdated() {
        self.todoProgress.value = self.calculateProgressPercentage()
        print(self.todoProgress.value)
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
    
    func editToDo(_ newToDo: ToDo) {
        ToDoManager.shared.todos.enumerated().forEach { (idx, searchedToDo) in
            if searchedToDo.id == newToDo.id { // found todo data to edit
                ToDoManager.shared.todos[idx] = newToDo
                ToDoManager.shared.update(newToDo)
            }
        }
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

// MARK: - Privates
private extension HomeViewModel {
    func calculateProgressPercentage() -> Int {
        let totalCount: Double = Double(ToDoManager.shared.todos.count)
        let finishedCount: Double = Double(ToDoManager.shared.todos.filter {
            $0.state == .completed
        }.count)
        if totalCount > 0 {
            return Int(round(finishedCount / totalCount * 100))
        } else {
            return 0
        }
    }
    
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
