//
//  Member.swift
//  todoey
//
//  Created by 이창준 on 2022/11/21.
//

import Foundation

struct Member: Codable {
    let id: String = UUID().uuidString
    let name: String
    let age: Int
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "memberId"
        case name, age, email
    }
}
