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
        self.todoData = ToDoManager.shared.read()
    }
    
    // MARK: - Functions
    func handleAddButtonTap() {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        print("Tapped")
    }
    
    func removeToDo(_ removingToDo: ToDo) {
        self.todoData?.enumerated().forEach { (index, todo) in
            if todo == removingToDo {
                self.todoData?.remove(at: index)
                ToDoManager.shared.delete(removingToDo)
            } else {
                fatalError("\(ToDoManagerError.notFound): Tried to remove non-exist data.")
            }
        }
    }
}
