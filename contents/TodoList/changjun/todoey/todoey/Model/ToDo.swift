//
//  ToDo.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import UIKit

struct ToDo: Codable, Identifiable {
    let id: String = UUID().uuidString
    var title: String
    var description: String
    var state: State
    var startDate: Date?
    var dueDate: Date?
    let created: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "todoId"
        case title
        case description = "content"
        case state = "completed"
        case startDate
        case dueDate
        case created
    }
}

enum State: Codable {
    case notStarted
    case inProgress
    case completed
    case expired
    
    var color: UIColor {
        switch self {
        case .notStarted:
            return Color.subGray
        case .inProgress:
            return UIColor.green
        case .completed:
            return BrandColor.brandBlue.value
        case .expired:
            return UIColor.red
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
