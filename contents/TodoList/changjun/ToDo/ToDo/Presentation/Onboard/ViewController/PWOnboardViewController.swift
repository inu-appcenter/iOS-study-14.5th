//
//  OnboardPWViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

import Hero
import SnapKit

final class PWOnboardViewController: OnboardViewController {
    
    // MARK: - Properties
    var viewModel: OnboardViewModel?
    
    // MARK: - UI Components
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showKeyboard()
    }
    
    // MARK: - UI Configuration
    override func configureUI() {
        super.configureUI()
        self.configureHero()
    }
    
    override func configureLayout() {
        super.configureLayout()
        [
            idLabel, idTextField,
            pwTextField
        ].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        self.confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).inset(-24)
        }
        self.idLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
        }
        self.idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.idLabel.snp.bottom)
        }
        self.pwTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalTo(self.confirmButton.snp.top).inset(-24)
        }
    }
    
    override func configureStyles() {
        super.configureStyles()
    }
    
    func configureHero() {
        self.idTextField.hero.id = HeroID.Onboard.idTextFieldTransition
        self.pwTextField.hero.id = HeroID.Onboard.passwordTextFieldTransition
    }
    
    // MARK: - Functions
    override func confirmButtonTap(_ sender: UIButton) {
        super.confirmButtonTap(sender)
        self.viewModel?.confirmButtonDidTap()
    }
    
    override func passwordTextFieldDidChange(_ sender: UITextField) {
        super.passwordTextFieldDidChange(sender)
        self.viewModel?.pwString.value = sender.text
    }
}

// MARK: - Private Functions
private extension PWOnboardViewController {
    func bindViewModel() {
        self.viewModel?.type.subscribe {
            self.confirmButton.setTitle($0.confirmButtonTitle, for: .normal)
        }
        self.viewModel?.idString.subscribe {
            self.idTextField.text = $0
        }
    }
    
    func showKeyboard() {
        self.pwTextField.becomeFirstResponder()
    }
}
