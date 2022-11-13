//
//  HomeViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/13.
//

import UIKit

final class HomeViewModel {
    
    // MARK: - Properties
    var todoData: [ToDo]? = ToDoManager.shared.read()
    
    // MARK: - Computed Properties
    var progressPercentage: String {
        return "70%"
    }
    
    var staticText: (String, String) {
        return ("오늘 할 일", "완료")
    }
    
    var welcomeString: String {
        return "돌아오셨군요"
    }
    
    var nameString: String {
        return "이창준"
    }
    
    var motivateString: String {
        return "오늘도 힘차게 출발해볼까요? 🔥"
    }
    
    var dayString: String {
        return "12"
    }
    
    var dayOfWeekString: String {
        return "Wed"
    }
    
    // MARK: - Functions
    func handleTap() {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        print("Tapped")
        
        
    }
}
