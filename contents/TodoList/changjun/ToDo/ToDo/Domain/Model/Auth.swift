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

struct AuthResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let msg: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
        case code, msg, token
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
        code = try container.decode(Int.self, forKey: .code)
        msg = try container.decode(String.self, forKey: .msg)
        token = try container.decode(String.self, forKey: .token)
    }
}
