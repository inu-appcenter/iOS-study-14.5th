//
//  extensions.swift
//  githubClone
//
//  Created by 김민정 on 2022/11/07.
//

import UIKit

enum PLImageSet {

    case python
    case java
    case swift
    case none
}

extension UIImageView {
    func setColor(style:PLImageSet){
        switch style {
        case .python:
            self.tintColor = #colorLiteral(red: 0.2078431373, green: 0.4470588235, blue: 0.6470588235, alpha: 1)
        case .java:
            self.tintColor = #colorLiteral(red: 0.6901960784, green: 0.4470588235, blue: 0.09803921569, alpha: 1)
        case .swift:
            self.tintColor = #colorLiteral(red: 0.9411764706, green: 0.3176470588, blue: 0.2196078431, alpha: 1)
        case .none:
            self.tintColor = .clear
        }
    }
}
