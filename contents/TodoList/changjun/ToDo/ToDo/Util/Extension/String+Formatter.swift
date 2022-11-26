//
//  String+Formatter.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

extension Int {
    func configureAttributedPercentage() -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        let regularAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21)]
        let smallAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        attributedString.append(
            NSMutableAttributedString(string: "\(self)", attributes: regularAttrs))
        attributedString.append(
            NSMutableAttributedString(string: "%", attributes: smallAttrs))
        return attributedString
    }
}
