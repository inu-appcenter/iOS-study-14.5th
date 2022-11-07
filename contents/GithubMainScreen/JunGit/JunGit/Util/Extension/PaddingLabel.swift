//
//  PaddingLabel.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

class PaddingLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 4.0
    @IBInspectable var bottomInset: CGFloat = 4.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(
            top: topInset,
            left: leftInset,
            bottom: bottomInset,
            right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(
            width: originalSize.width + leftInset + rightInset,
            height: originalSize.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
