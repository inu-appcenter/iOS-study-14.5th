//
//  EditViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import UIKit

import Hero
import SnapKit

final class EditViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: EditViewModel?
    
    // MARK: - UI Components
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 21, weight: .semibold)
        textField.textColor = .white
        textField.returnKeyType = .done
        textField.delegate = self
        textField.placeholder = "추가할 할 일을 입력해주세요."
        textField.setPlaceholderColor(.tdLightGray)
        textField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = .autoupdatingCurrent
        datePicker.datePickerMode = .date
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.tintColor = .tdBlue
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.addTarget(self, action: #selector(dueDatePickerDidChange(_:)), for: .valueChanged)
        return datePicker
    }()
    
    lazy var descriptionTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = .white
        textView.textAlignment = .natural
        textView.returnKeyType = .done
        textView.delegate = self
        textView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(200)
        }
        return textView
    }()
    
    lazy var confirmButton: ConfirmButton = {
        let button = ConfirmButton()
        button.addTarget(self, action: #selector(confirmButtonDidTap(_:)), for: .touchUpInside)
        button.hero.id = HeroID.Home2Edit.buttonTransition
        return button
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel()
        self.configureUI()
        self.showKeyboard()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Functions
    func bindViewModel() {
//        self.titleTextField.text = self.viewModel?.todo.value?.title
//        self.descriptionTextField.text = self.viewModel?.todo.value?.description
//        if let dueDate = self.viewModel?.todo.value?.dueDate {
//            self.datePicker.date = dueDate
//        }
        self.viewModel?.todo.subscribe(listener: { todo in
            self.titleTextField.text = todo?.title
            self.descriptionTextField.text = todo?.description
            self.datePicker.date = todo?.dueDate ?? .now
        })
    }
    
    @objc
    func backButtonDidTap(_ sender: UIBarButtonItem) {
        self.viewModel?.coordinator?.finish()
    }
    
    @objc
    func confirmButtonDidTap(_ sender: UIButton) {
        self.viewModel?.confirmButtonDidTap {
            self.viewModel?.coordinator?.finish()
        }
    }
    
    @objc
    func titleTextFieldDidChange(_ sender: UITextField) {
        self.viewModel?.updateToDoTitle(to: sender.text)
    }
    
    @objc
    func dueDatePickerDidChange(_ sender: UIDatePicker) {
        self.viewModel?.updateToDoDueDate(to: sender.date)
    }
}

// MARK: - UI Configuration
private extension EditViewController {
    func configureUI() {
        self.configureNavigationBar()
        self.configureHero()
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .tdBlue
        let backButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap(_:))
        )
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    func configureHero() {
        self.hero.isEnabled = true
        self.view.hero.id = HeroID.Home2Edit.todoViewTransition
    }
    
    func configureLayout() {
        [titleTextField, datePicker, descriptionTextField, confirmButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.width.equalToSuperview().inset(24)
        }
        self.datePicker.snp.makeConstraints { make in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(24)
        }
        self.descriptionTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.datePicker.snp.bottom).offset(18)
            make.bottom.equalTo(self.confirmButton.snp.top).inset(-24)
            make.width.equalToSuperview().inset(24)
        }
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-12)
            make.width.equalToSuperview().inset(24)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .tdGray
        self.confirmButton.setTitle(self.viewModel?.confirmButtonText, for: .normal)
    }
    
    func showKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.titleTextField.becomeFirstResponder()
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

// MARK: - Text View
extension EditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.viewModel?.updateToDoDescription(to: textView.text)
    }
}
