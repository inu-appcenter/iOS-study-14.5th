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
    
    // MARK: - Properties
    var dismissClosure: (() -> Void)?
    var viewModel = EditViewModel()
    
    // MARK: - UI Components
    lazy var titleTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 21, weight: .semibold)
        $0.returnKeyType = .done
        $0.delegate = self
        $0.placeholder = "추가할 할 일을 입력해주세요."
        $0.becomeFirstResponder()
    }
    
    lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .compact
        $0.locale = Locale(identifier: "ko-KR")
        $0.datePickerMode = .date
        $0.timeZone = .autoupdatingCurrent
        $0.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    
    lazy var descriptionTextField = UITextView().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textAlignment = .natural
        $0.returnKeyType = .done
    }
    
    lazy var confirmButton = UIButton().then {
        $0.backgroundColor = BrandColor.brandBlue.value
        $0.setTitleColor(Color.subGray, for: .highlighted)
        $0.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
        self.hideKeyboardWhenTapped()
        self.bindViewModel()
    }
}

// MARK: - Binding
private extension EditViewController {
    func bindViewModel() {
        self.viewModel.isEdit.subscribe { isEdit in
            if isEdit {
                self.confirmButton.setTitle("수정하기", for: .normal)
                self.viewModel.todoData.subscribe { todo in
                    if let todo {
                        self.titleTextField.text = todo.title
                        self.datePicker.date = todo.dueDate!
                        self.descriptionTextField.text = todo.description
                    }
                }
            } else {
                self.confirmButton.setTitle("추가하기", for: .normal)
            }
        }
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
        [titleTextField, datePicker, descriptionTextField, confirmButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.width.equalToSuperview().inset(24)
        }
        self.datePicker.snp.makeConstraints { make in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(24)
        }
        self.descriptionTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.datePicker.snp.bottom).offset(18)
            make.height.equalTo(150)
            make.width.equalToSuperview().inset(24)
        }
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-24)
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
        self.confirmButton.layer.cornerRadius = 24
    }
}

// MARK: - Private
private extension EditViewController {
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    @objc func doneButtonPressed() {
        if self.viewModel.isEdit.value {
            self.viewModel.editToDo(
                self.titleTextField.text!,
                self.descriptionTextField.text,
                self.datePicker.date
            )
        } else {
            if let text = self.titleTextField.text {
                self.viewModel.createToDo(
                    text,
                    self.descriptionTextField.text,
                    self.datePicker.date
                )
            }
        }
        // TODO ToDoView의 컬렉션뷰 리로드
        NotificationCenter.default.post(name: Notification.Name.refresh, object: nil)
        self.dismiss(animated: true) {
            self.dismissClosure?()
        }
    }
}

// MARK: - Text Field

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct EditViewControllerPreView: PreviewProvider {
  static var previews: some View {
    EditViewController().toPreview()
  }
}
#endif
