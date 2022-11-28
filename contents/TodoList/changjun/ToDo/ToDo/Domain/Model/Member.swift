//
//  Member.swift
//  todoey
//
//  Created by 이창준 on 2022/11/21.
//
import Foundation

struct Member: Codable {
    let age: Int
    let email: String
    let id: Int
    let name: String
    let todo: [ToDoDTO]
    
    enum CodingKeys: String, CodingKey {
        case age, email, id, name
        case todo = "todoList"
    }
}
