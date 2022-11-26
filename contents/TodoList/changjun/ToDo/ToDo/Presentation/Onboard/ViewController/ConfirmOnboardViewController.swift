//
//  ConfirmOnboardViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

import Hero
import SnapKit

final class ConfirmOnboardViewController: OnboardViewController {
    
    // MARK: - Properties
    var viewModel: OnboardViewModel?
    
    // MARK: - UI Components
    lazy var confirmLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .tdPink
        label.text = "아래 정보가 맞나요?"
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .tdGray
        label.text = "틀린 정보를 터치해서 수정할 수 있어요."
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UI Configuration
    override func configureUI() {
        super.configureUI()
        self.configureHero()
    }
    
    override func configureLayout() {
        super.configureLayout()
        [
            confirmLabel, descriptionLabel,
            idTextField,
            pwTextField,
            nameTextField,
            ageTextField
        ].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        self.confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).inset(-24)
        }
        self.confirmLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(18)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.confirmLabel.snp.bottom).offset(4)
        }
        self.idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(24)
        }
        self.pwTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.idTextField.snp.bottom).inset(-12)
        }
        self.nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.pwTextField.snp.bottom).inset(-12)
        }
        self.ageTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.nameTextField.snp.bottom).inset(-12)
        }
    }
    
    override func configureStyles() {
        super.configureStyles()
    }
    
    func configureHero() {
        self.ageTextField.hero.id = HeroID.Onboard.ageTextFieldTransition
    }
    
    // MARK: - Functions
    override func confirmButtonTap(_ sender: UIButton) {
        super.confirmButtonTap(sender)
        self.viewModel?.confirmButtonDidTap()
    }
}

// MARK: - Private Functions
private extension ConfirmOnboardViewController {
    func bindViewModel() {
        self.viewModel?.type.subscribe {
            self.confirmButton.setTitle($0.confirmButtonTitle, for: .normal)
        }
        self.viewModel?.idString.subscribe {
            self.idTextField.text = $0
        }
        self.viewModel?.pwString.subscribe {
            self.pwTextField.text = $0
        }
        self.viewModel?.nameString.subscribe {
            self.nameTextField.text = $0
        }
        self.viewModel?.ageString.subscribe {
            guard let age = $0 else { return }
            self.ageTextField.text = String(age)
        }
    }
}
