//
//  SummaryViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/24.
//

import Foundation

final class SummaryViewModel: ChildViewModel {
    
    // MARK: - Properties
    var parentViewModel: ViewModel?
    
    // MARK: - Observables
    let todoProgress: Observable<Int> = Observable(0)
    
    // MARK: - Initializer
    init(parentViewModel: ViewModel?) {
        self.parentViewModel = parentViewModel
    }
    
    // MARK: - Functions
    func updateProgress() {
        let todos = ToDoManager.shared.todos
        let doneToDos = todos.filter { $0.state == .completed }
        self.todoProgress.value = Int(round(Double(doneToDos.count) / Double(todos.count) * 100))
    }
}
