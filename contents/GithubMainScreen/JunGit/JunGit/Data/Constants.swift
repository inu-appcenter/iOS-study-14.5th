//
//  Constants.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/24.
//

import Foundation

struct K {
    
    // MARK: - Commons
    struct Profile {
        static let userName: String = "이창준"
        static let userID: String = "StanSign"
        static let userImage: String = "ProfileImage"
        static let userStatus: String = "📱"
        static let userMessage: String = "2022 졸작 & iOS 부스트"
    }
    
    // MARK: - File Names
    struct FileName {
        static let ProfileBioView = "ProfileBioView"
        static let menuTableViewCell = "MenuTableViewCell"
    }
    
    // MARK: - Identifiers
    struct Identifier {
        static let profileCell: String = "ProfileCell"
        static let menuCell: String = "MenuTableViewCell"
    }
    
    // MARK: - Icons
    struct Icon {
        static let undefined = "questionmark.square"
        static let shareIcon = "square.and.arrow.up"
        static let settingsIcon = "gearshape"
    }
    
    // MARK: - Images
    struct Image {
        static let profilePlaceholder = "ProfilePlaceholder"
    }
}
