//
//  PinnedData.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

enum Pinned: CaseIterable {
    case assemble
    case capstone
    
    enum ProgramLang: String {
        case python = "Python"
        case swift = "Swift"
    }
    
    var name: String {
        switch self {
        case .assemble:
            return "Assemble"
        case .capstone:
            return "Capstone-Zigbee"
        }
    }
    
    var description: String {
        switch self {
        case .assemble:
            return "히어로 영화 정보 모음 DB앱"
        case .capstone:
            return "상황과 분위기에 중점을 둔 새로운 스마트홈 플랫폼 프로젝트"
        }
    }
    
    var starred: Int {
        switch self {
        case .assemble:
            return 0
        case .capstone:
            return 0
        }
    }
    
    var language: ProgramLang {
        switch self {
        case .assemble:
            return .swift
        case .capstone:
            return .python
        }
    }
    
    var dotColor: UIColor {
        switch self {
        case .assemble:
            return UIColor(named: "SwiftOrange")!
        case .capstone:
            return UIColor(named: "PythonBlue")!
        }
    }
}
