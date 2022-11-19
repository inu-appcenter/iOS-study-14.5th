//
//  HomeViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/13.
//

import UIKit

final class HomeViewModel {
    // MARK: - Singleton
    static let shared = HomeViewModel()
    
    // MARK: - Computed Properties
    
    // Summary View
    
    var staticText: (String, String) {
        return ("이만큼이나", "완료했어요!")
    }
    
    // Profile View
    var welcomeString: String {
        return "돌아오셨군요"
    }
    
    var nameString: String {
        return "이창준"
    }
    
    // Calendar View
    var dayString: String {
        return "12"
    }
    
    var dayOfWeekString: String {
        return "Wed"
    }

    // MARK: - Summary View
    let currentTime: Observable<Date> = Observable(.now)
    let todoProgress: Observable<Int> = Observable(0)
    
    // MARK: - Initializer
    init() {
        
    }
    
    // MARK: - Functions
    func todoUpdated() {
        self.todoProgress.value = self.calculateProgressPercentage()
        print(self.todoProgress.value)
    }
    
    // MARK: - Old Functions
    
    func handleAddButtonTapEvent() {
        HapticManager.shared.impactFeedback(.light)
        print("Tapped")
    }
    
    func editToDo(_ toggledToDo: ToDo) {
        ToDoManager.shared.todos.enumerated().forEach { (index, todo) in
            if todo.id == toggledToDo.id {
                var newToDo = toggledToDo
                if newToDo.state == .notStarted {
                    newToDo.state = .completed
                } else {
                    newToDo.state = .notStarted
                }
                ToDoManager.shared.todos.remove(at: index)
                ToDoManager.shared.todos.insert(newToDo, at: index)
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
}
