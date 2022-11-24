//
//  UIDatePicker+TextColor.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/24.
//

import UIKit

extension UIDatePicker {
    var textColor: UIColor? {
        set {
            setValue(newValue, forKey: "textColor")
        }
        get {
            return value(forKey: "textColor") as? UIColor
        }
    }
}
