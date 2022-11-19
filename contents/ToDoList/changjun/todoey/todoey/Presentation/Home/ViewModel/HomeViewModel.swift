//
//  HomeViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/13.
//

import UIKit

final class HomeViewModel {
    
    // MARK: - Computed Properties
    
    // Summary View
    var progressPercentage: String {
        let completedToDos = ToDoManager.shared.todos.filter {
            $0.state == .completed
        }.count
        let allToDos = ToDoManager.shared.todos.count
        let result = (Double(completedToDos) / Double(allToDos)) * 100
        return "\(Int(round(result)))%"
    }
    
    var staticText: (String, String) {
        return ("오늘 할 일", "완료")
    }
    
    // Profile View
    var welcomeString: String {
        return "돌아오셨군요"
    }
    
    var nameString: String {
        return "이창준"
    }
    
    var motivateString: String {
        return "오늘도 힘차게 출발해볼까요? 🔥"
    }
    
    // Calendar View
    var dayString: String {
        return "12"
    }
    
    var dayOfWeekString: String {
        return "Wed"
    }

    // MARK: - Input
    struct Input {
        
    }
    
    // MARK: - Output
    struct Output {
        
    }
    
    
    // MARK: - Initializer
    init() {
        
    }
    
    // MARK: - Functions
    func handleAddButtonTapEvent() {
        HapticManager.shared.impactFeedback(.light)
        print("Tapped")
    }
    
    func editToDo(_ toggledToDo: ToDo) {
        ToDoManager.shared.todos.enumerated().forEach { (index, todo) in
            if todo == toggledToDo {
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
            if todo == removingToDo {
                ToDoManager.shared.todos.remove(at: index)
                ToDoManager.shared.delete(removingToDo)   
            }
        }
    }
}
