//
//  HomeViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/13.
//

import UIKit

final class HomeViewModel {
    
    // MARK: - Properties
    var todoData: [ToDo]?
    
    // MARK: - Computed Properties
    
    // Summary View
    var progressPercentage: String {
        return "70%"
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
    
    // MARK: - Initializer
    init() {
        self.updateToDo()
    }
    
    // MARK: - Functions
    func handleAddButtonTapEvent() {
        HapticManager.shared.impactFeedback(.light)
        print("Tapped")
    }
    
    func syncToDoData() {
        print("Syncing ToDo UserDefaults to temporary data.")
        self.updateToDo()
    }
    
    func editToDo(_ toggledToDo: ToDo) {
        self.todoData?.enumerated().forEach { (index, todo) in
            if todo == toggledToDo {
                var newToDo = toggledToDo
                if newToDo.state == .notStarted {
                    newToDo.state = .completed
                } else {
                    newToDo.state = .notStarted
                }
                self.todoData?.remove(at: index)
                self.todoData?.insert(newToDo, at: index)
                ToDoManager.shared.update(newToDo)
            }
        }
    }
    
    func removeToDo(_ removingToDo: ToDo) {
        self.todoData?.enumerated().forEach { (index, todo) in
            if todo == removingToDo {
                self.todoData?.remove(at: index)
                ToDoManager.shared.delete(removingToDo)   
            }
        }
    }
}

private extension HomeViewModel {
    func updateToDo() {
        self.todoData = ToDoManager.shared.read()
    }
}
