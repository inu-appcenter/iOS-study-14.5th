//
//  MenuData.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

enum Menu: CaseIterable {
    case repositories
    case starred
    case organizations
    
    var iconImage: String {
        switch self {
        case .repositories:
            return "text.book.closed"
        case .starred:
            return "star"
        case .organizations:
            return "building.2"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .repositories:
            return UIColor.darkGray
        case .starred:
            return UIColor.systemYellow
        case .organizations:
            return UIColor.systemOrange
        }
    }
    
    var menuLabel: String {
        switch self {
        case .repositories:
            return "Repositories"
        case .starred:
            return "Starred"
        case .organizations:
            return "Organizations"
        }
    }
    
    var numberOfContents: Int {
        switch self {
        case .repositories:
            return 18
        case .starred:
            return 23
        case .organizations:
            return 1
        }
    }
}
