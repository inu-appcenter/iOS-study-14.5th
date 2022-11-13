//
//  EditViewController.swift
//  todoey
//
//  Created by 이창준 on 2022/11/13.
//

import UIKit

import Then
import SnapKit

class EditViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var textField = UITextField().then {
        $0.returnKeyType = .done
        $0.delegate = self
        $0.placeholder = "추가할 할 일을 입력해주세요."
        $0.becomeFirstResponder()
    }
    
    lazy var testButton = UIButton().then {
        $0.backgroundColor = BrandColor.brandBlue.value
        $0.setTitle("추가하기", for: .normal)
        $0.setTitleColor(Color.subGray, for: .highlighted)
        $0.addTarget(self, action: #selector(exit), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
        self.hideKeyboardWhenTapped()
    }

    @objc func exit() {
        self.dismiss(animated: true)
    }
}

// MARK: - UI Configuration
private extension EditViewController {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [textField, testButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.width.equalToSuperview().inset(24)
        }
        self.testButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-24)
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
        self.testButton.layer.cornerRadius = 24
    }
}

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
