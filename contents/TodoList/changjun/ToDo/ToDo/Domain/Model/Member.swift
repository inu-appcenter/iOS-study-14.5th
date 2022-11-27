//
//  Member.swift
//  todoey
//
//  Created by 이창준 on 2022/11/21.
//
import Foundation

struct Member: Codable {
    let name: String
    let age: Int
    
    enum CodingKeys: String, CodingKey {
        case name, age
    }
}
