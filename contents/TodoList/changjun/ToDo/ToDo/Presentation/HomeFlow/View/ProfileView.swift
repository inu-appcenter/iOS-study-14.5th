//
//  ProfileView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/09.
//

import UIKit

import SnapKit

final class ProfileView: UIView {
    
    // MARK: - UI Components
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "person_placeholder")
        return imageView
    }()
    
    lazy var welcomeLabelStackView: UIStackView = {
        let stackView = UIStackView()
        let welcomeLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12, weight: .regular)
            return label
        }()
        let profileNameLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12, weight: .semibold)
            return label
        }()
        let tailLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12, weight: .regular)
            label.text = "님!"
            return label
        }()
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(profileNameLabel)
        stackView.addArrangedSubview(tailLabel)
        stackView.spacing = 4
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.addArrangedSubview(self.welcomeLabelStackView)
        stackView.addArrangedSubview(self.commentLabel)
        return stackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel() {
//        self.viewModel.currentTime.subscribe { [weak self] in
//            self?.commentLabel.text = $0.toMotivateString()
//        }
    }
}

// MARK: - Private Functions
private extension ProfileView {
    func configureUI() {
        self.addSubview(self.profileImageView)
        self.addSubview(self.stackView)
        self.profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        self.stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.profileImageView.snp.right).offset(12)
        }
    }
}
