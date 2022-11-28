//
//  Auth.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/27.
//

import Foundation

struct Auth: Codable {
    let id: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case id = "memberId"
        case password = "password"
    }
}

struct AuthResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let msg: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
        case code, msg, token
    }
}
