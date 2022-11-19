//
//  StatusView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import UIKit

import Then
import SnapKit

class StatusView: UIView {
    
    // MARK: - UI Components
    lazy var statusDotImage = UIImageView().then {
        $0.tintColor = .red
        $0.image = UIImage(systemName: "circle.fill")
    }
    
    lazy var statusLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .systemRed
        $0.text = "기한 지남"
    }
    
    lazy var stackView = UIStackView().then {
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .center
        $0.axis = .horizontal
        $0.addArrangedSubview(self.statusDotImage)
        $0.addArrangedSubview(self.statusLabel)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setColor(to color: UIColor) {
        self.statusDotImage.tintColor = color
        self.statusLabel.textColor = color
    }
}

// MARK: - UI Configuration
private extension StatusView {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [stackView].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.statusDotImage.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        self.stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    func configureStyles() {
        self.backgroundColor = .clear
    }
}

