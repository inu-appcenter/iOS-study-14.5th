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
    
    // MARK: - Observables
    let currentTime: Observable<Date> = Observable(.now)
    let todoProgress: Observable<Int> = Observable(0)
    
    // MARK: - Initializer
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Functions
    func todoUpdated() {
        self.todoProgress.value = self.calculateProgressPercentage()
        print(self.todoProgress.value)
    }
    
    func convertDate(_ date: Date, to format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let convertedDateString = dateFormatter.string(from: date)
        
        return convertedDateString
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
