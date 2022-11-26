//
//  OnboardViewType.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

enum OnboardType {
    case start, id, pw, name, age, confirm, result
    
    var confirmButtonTitle: String {
        switch self {
        case .start:
            return "시작하기"
        case .id:
            fallthrough
        case .pw:
            fallthrough
        case .name:
            fallthrough
        case .age:
            return "다음으로"
        case .confirm:
            return "전부 확인했어요!"
        case .result:
            return "시작해볼까요?"
        }
    }
}
