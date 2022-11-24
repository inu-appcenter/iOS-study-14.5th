//
//  EditUseCase.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

final class EditUseCase {
    
    // MARK: - Initializer
    init() {
        
    }
    
    // MARK: - Functions
    func createToDo(_ todo: ToDo, completion: (() -> Void)) {
        print(todo)
        ToDoManager.shared.create(todo)
        completion()
    }
    
    func updateToDo(_ todo: ToDo, completion: (() -> Void)) {
        print(todo)
        ToDoManager.shared.update(todo)
        completion()
    }
}
