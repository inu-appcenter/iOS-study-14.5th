//
//  ResultOnboardViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/27.
//

import UIKit

import Hero
import SnapKit

final class ResultOnboardViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: OnboardViewModel?
    
    // MARK: - UI Components
    lazy var confirmButton: ConfirmButton = {
        let button = ConfirmButton()
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - UI Configuration
private extension ResultOnboardViewController {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [confirmButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(48)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
    }
}

// MARK: - Private Functions
private extension ResultOnboardViewController {
    @objc
    func buttonDidTap(_ sender: UIButton) {
        self.viewModel?.confirmButtonDidTap()
    }
}
