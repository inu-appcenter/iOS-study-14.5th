//
//  ToDoViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import UIKit

final class ToDoViewModel {
    var todoData: [ToDo]? = ToDoManager.shared.read()
    
    func handleTap() {
        let haptic = UIImpactFeedbackGenerator()
        haptic.impactOccurred()
        print("Tapped")
        
        
    }
}
