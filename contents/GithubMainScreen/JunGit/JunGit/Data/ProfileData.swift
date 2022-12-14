//
//  ProfileData.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/24.
//

import UIKit

enum Profile: CaseIterable {
    static var allCases: [Profile] {
        return [.workplace, .location, .link, .email, .follow(follower: 9, following: 15)]
    }
    
    case workplace
    case location
    case link
    case email
    case follow(follower: Int, following: Int)
    
    var iconImage: String {
        switch self {
        case .workplace:
            return "building.2"
        case .location:
            return "mappin.and.ellipse"
        case .link:
            return "link"
        case .email:
            return "envelope"
        case .follow(follower: _, following: _):
            return "person"
        }
    }
    
    var data: String {
        switch self {
        case .workplace:
            return "Incheon National University"
        case .location:
            return "경기도 부천시"
        case .link:
            return "stansign.github.io"
        case .email:
            return "nomatterjun@gmail.com"
        case .follow(follower: let follower, following: let following):
            return "\(follower) followers · \(following) following"
        }
    }
    
    var font: UIFont {
        switch self {
        case .workplace, .location:
            return UIFont.systemFont(ofSize: 14, weight: .light)
        case .link, .email:
            return UIFont.systemFont(ofSize: 15, weight: .semibold)
        case .follow(follower: _, following: _):
            return UIFont.systemFont(ofSize: 13, weight: .light)
        }
    }
}
