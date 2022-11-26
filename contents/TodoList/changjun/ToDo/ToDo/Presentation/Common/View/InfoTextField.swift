//
//  InfoTextField.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/27.
//

import UIKit

import Hero
import SkyFloatingLabelTextField

final class InfoTextField: SkyFloatingLabelTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InfoTextField {
    func configureUI() {
        self.font = .systemFont(ofSize: 24, weight: .semibold)
        self.selectedTitleColor = .tdBlue
        self.selectedLineColor = .tdBlue
        self.enablesReturnKeyAutomatically = true
        self.isHeroEnabled = true
    }
}
