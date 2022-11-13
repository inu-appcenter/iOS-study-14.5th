//
//  Colors.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import Foundation

import Hue

struct Color {
    static let deepGray = UIColor(hex: "#2D2D2D")
    static let lightGray = UIColor(hex: "#F5F5F5")
    static let subGray = UIColor(hex: "ACACAC")
    
    static let gradient = [
        BrandColor.brandBlue.value,
        BrandColor.brandPink.value,
        BrandColor.brandPurple.value
    ].gradient()
}

enum BrandColor: CaseIterable {
    case brandBlue
    case brandPink
    case brandPurple
    
    var value: UIColor {
        switch self {
        case .brandBlue:
            return UIColor(hex: "#7064B3")
        case .brandPink:
            return UIColor(hex: "#A25FA7")
        case .brandPurple:
            return UIColor(hex: "#D15C9C")
        }
    }
}
