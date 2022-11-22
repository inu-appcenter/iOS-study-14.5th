//
//  StatusView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import UIKit

import SnapKit

class StatusView: UIView {
    
    // MARK: - UI Components
    lazy var statusDotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .red
        imageView.image = UIImage(systemName: "circle.fill")
        return imageView
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemRed
        label.text = "기한 지남"
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.addArrangedSubview(self.statusDotImage)
        stackView.addArrangedSubview(self.statusLabel)
        return stackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setStatus(_ state: State?) {
        if let state {
            self.statusLabel.text = state.value
            self.setColor(to: state.color)
        }
    }
    
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
