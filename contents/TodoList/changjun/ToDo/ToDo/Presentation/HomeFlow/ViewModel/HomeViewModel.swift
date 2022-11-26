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
        self.syncViewModel()
    }
    
    // MARK: - Functions
    func addButtonDidTap() {
        self.coordinator?.showCreateFlow()
    }
    
    func syncViewModel() {
        self.todoProgress.value = ToDoManager.shared.calculateProgressPercentage()
    }
}

// MARK: - Privates
private extension HomeViewModel {
    
    func handleStateWithDate(of todo: ToDo) -> State {
        if let due = todo.dueDate {
            if due.onlyDate < Date.now.onlyDate {
                return .expired
            } else {
                return .inProgress
            }
        }
        return .completed
    }
}
