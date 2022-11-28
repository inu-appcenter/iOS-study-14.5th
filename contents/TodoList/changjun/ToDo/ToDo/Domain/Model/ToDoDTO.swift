//
//  ToDo.swift
//  ToDO
//
//  Created by 이창준 on 2022/11/12.
//
import UIKit

struct ToDoDTO: Codable {
    let id: Int
    let memberID: Int
    var title: String
    var description: String
    var state: State
    var dueDate: Date?
    let created: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "todoId"
        case memberID = "idOfMember"
        case title
        case description = "content"
        case state = "completed"
        case dueDate
        case created
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        memberID = try container.decode(Int.self, forKey: .memberID)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        state = try container.decode(State.self, forKey: .state)
        dueDate = try container.decode(Date.self, forKey: .dueDate)
        created = try container.decode(Date.self, forKey: .created)
    }
}

enum State: String, Codable {
    case notStarted
    case inProgress
    case completed
    case expired
    
    enum CodingKeys: String, CodingKey {
        case notStarted
        case inProgress
        case completed
        case expired
    }
    
    var color: UIColor {
        switch self {
        case .notStarted:
            return .tdLightGray
        case .inProgress:
            return .systemGreen
        case .completed:
            return .tdBlue
        case .expired:
            return .systemRed
        }
    }
    
    var value: String {
        switch self {
        case .notStarted:
            return "시작 전"
        case .inProgress:
            return "진행 중"
        case .completed:
            return "완료"
        case .expired:
            return "기한 지남"
        }
    }
}
