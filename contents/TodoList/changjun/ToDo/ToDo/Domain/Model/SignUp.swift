//
//  SignUp.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/27.
//

import Foundation

struct SignUp: Codable {
    let id: String
    let password: String
    let name: String
    let age: Int
    let email: String = "nodata@blank.com"
    let role: String = "admin"
    
    enum CodingKeys: String, CodingKey {
        case id = "memberId"
        case password = "password"
        case name, age, email, role
    }
}
