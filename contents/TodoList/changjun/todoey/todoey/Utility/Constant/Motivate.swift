//
//  Motivate.swift
//  todoey
//
//  Created by 이창준 on 2022/11/19.
//

import Foundation

enum Motivate {
    case morning, noon, evening, dawn
    
    var motivateString: String {
        switch self {
        case .morning:
            return "오늘도 힘차게 출발해볼까요? 🔥"
        case .noon:
            return "잘 하고 있어요! 영차영차 💪"
        case .evening:
            return "오늘 하루를 정리해봐요. ✨"
        case .dawn:
            return "할 일이 많으신가봐요.. 🌀"
        }
    }
}
