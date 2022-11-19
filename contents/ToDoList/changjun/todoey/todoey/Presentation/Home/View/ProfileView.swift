//
//  ProfileView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/09.
//

import UIKit

import SnapKit
import Then

final class ProfileView: UIView {
    
    private var viewModel = HomeViewModel()
    
    // MARK: - UI Components
    lazy var profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.image = UIImage(named: "person_placeholder")
    }
    
    lazy var welcomeLabelStackView = UIStackView().then {
        let welcomeLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 12, weight: .regular)
            $0.text = self.viewModel.welcomeString
        }
        let profileNameLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 12, weight: .semibold)
            $0.text = self.viewModel.nameString
        }
        let tailLabel = UILabel().then {
            $0.font = .systemFont(ofSize: 12, weight: .regular)
            $0.text = "님!"
        }
        $0.addArrangedSubview(welcomeLabel)
        $0.addArrangedSubview(profileNameLabel)
        $0.addArrangedSubview(tailLabel)
        $0.spacing = 4
        $0.axis = .horizontal
    }
    
    lazy var commentLabel = UILabel().then {
        $0.text = viewModel.motivateString
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
    }
    
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .leading
        $0.addArrangedSubview(self.welcomeLabelStackView)
        $0.addArrangedSubview(self.commentLabel)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProfileViewPreView: PreviewProvider {
    static var previews: some View {
        ProfileView().toPreview()
    }
}
#endif
