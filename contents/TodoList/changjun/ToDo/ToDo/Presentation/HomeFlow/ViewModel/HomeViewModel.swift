//
//  HomeViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import Foundation

final class HomeViewModel: ViewModel {
    
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
    
    // MARK: - Functions
    func addButtonDidTap() {
        self.coordinator?.showCreateFlow()
    }
    
    func todoUpdated() {
        self.todoProgress.value = self.calculateProgressPercentage()
        print(self.todoProgress.value)
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
