//
//  OnboardIDViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

import Hero
import SnapKit

final class IDOnboardViewController: OnboardViewController {
    
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
        [confirmButton, idTextField].forEach {
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
            make.bottom.equalTo(self.confirmButton.snp.top).inset(-24)
        }
    }
    
    override func configureStyles() {
        super.configureStyles()
        self.idTextField.isHidden = false
    }
    
    func configureHero() {
        self.idTextField.hero.id = HeroID.Onboard.idTextFieldTransition
    }
    
    // MARK: - Functions
    override func confirmButtonTap(_ sender: UIButton) {
        super.confirmButtonTap(sender)
        self.viewModel?.confirmButtonDidTap()
    }
    
    override func idTextFieldDidChange(_ sender: UITextField) {
        super.idTextFieldDidChange(sender)
        self.viewModel?.idString.value = sender.text
    }
}

// MARK: - Private Functions
private extension IDOnboardViewController {
    func bindViewModel() {
        self.viewModel?.type.subscribe {
            self.confirmButton.setTitle($0.confirmButtonTitle, for: .normal)
        }
    }
    
    func showKeyboard() {
        DispatchQueue.main.async {
            self.idTextField.becomeFirstResponder()
        }
    }
    
    func hideKeyboard() {
        DispatchQueue.main.async {
            self.idTextField.resignFirstResponder()
        }
    }
}
