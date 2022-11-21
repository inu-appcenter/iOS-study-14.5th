//
//  URL.swift
//  todoey
//
//  Created by 이창준 on 2022/11/21.
//

import Foundation

enum URL {
    // Members
    case memberID // GET, POST
    case byMemberID // GET, PUT, DELETE
    // ToDo
    case todos // POST
    case byToDoID // GET, PUT, DELETE
    
    var path: String {
        switch self {
        case .memberID:
            return "/members"
        case .byMemberID:
            return "/members/" // memberID
        case .todos:
            return "/todos"
        case .byToDoID:
            return "/todos/" // todoID
        }
    }
}
