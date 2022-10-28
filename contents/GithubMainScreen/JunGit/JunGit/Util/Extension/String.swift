//
//  String.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

extension String {
    var indicesOfNumbers: [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        while searchStartIndex < self.endIndex,
              let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits,
                                                range: searchStartIndex..<self.endIndex),
              !range.isEmpty {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            if index > 0 {
                let previousIndex = self.index(self.startIndex, offsetBy: index - 1)
                if let previousCharacter = self[previousIndex].unicodeScalars.first,
                   (previousCharacter == "." || previousCharacter == ",") {
                    indices.append(index - 1)
                }
            }
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        return indices
    }
    
    func boldDecimals(size: CGFloat, font: UIFont) -> NSAttributedString {
        let indicesOfNumbers = self.indicesOfNumbers
        let regularAttrs = [NSAttributedString.Key.font: font]
        let boldAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)]
        let attributedString = NSMutableAttributedString()
        for (index, char) in self.enumerated() {
            if indicesOfNumbers.contains(index) {
                attributedString.append(NSMutableAttributedString(string: String(char), attributes: boldAttrs))
            } else {
                attributedString.append(NSMutableAttributedString(string: String(char), attributes: regularAttrs))
            }
        }
        return attributedString
    }
}
