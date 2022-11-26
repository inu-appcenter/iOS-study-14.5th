//
//  ConfirmButton.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

import SnapKit

final class ConfirmButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConfirmButton {
    func configureUI() {
        self.backgroundColor = .tdBlue
        self.setTitleColor(.tdLightGray, for: .highlighted)
        self.layer.cornerRadius = 18
        self.clipsToBounds = true
        self.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
}
