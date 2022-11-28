//
//  NameOnboardViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

import Hero
import SnapKit

final class NameOnboardViewController: OnboardViewController {
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideKeyboard()
    }
    
    // MARK: - UI Configuration
    override func configureUI() {
        super.configureUI()
        self.configureHero()
    }
    
    override func configureLayout() {
        super.configureLayout()
        [
            idTextField,
            pwTextField,
            nameTextField
        ].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        self.confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).inset(-24)
        }
        self.idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(18)
        }
        self.pwTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(self.idTextField.snp.bottom).inset(-12)
        }
        self.nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalTo(self.confirmButton.snp.top).inset(-24)
        }
    }
    
    override func configureStyles() {
        super.configureStyles()
    }
    
    func configureHero() {
        self.pwTextField.hero.id = HeroID.Onboard.passwordTextFieldTransition
        self.nameTextField.hero.id = HeroID.Onboard.nameTextFieldTransition
    }
    
    // MARK: - Functions
    override func confirmButtonTap(_ sender: UIButton) {
        super.confirmButtonTap(sender)
        self.viewModel?.confirmButtonDidTap()
    }
    
    override func nameTextFieldDidChange(_ sender: UITextField) {
        super.nameTextFieldDidChange(sender)
        self.viewModel?.nameString.value = sender.text
    }
}

// MARK: - Private Functions
private extension NameOnboardViewController {
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
    }
    
    func showKeyboard() {
        DispatchQueue.main.async {
            self.nameTextField.becomeFirstResponder()
        }
    }
    
    func hideKeyboard() {
        DispatchQueue.main.async {
            self.nameTextField.resignFirstResponder()
        }
    }
}
