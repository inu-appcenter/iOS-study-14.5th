//
//  ToDoViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import Foundation

struct ToDoViewModel {
    var todoData: [ToDo]? = ToDoManager.shared.read()
}
