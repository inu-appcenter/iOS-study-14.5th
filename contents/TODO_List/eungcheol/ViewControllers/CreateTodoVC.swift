import UIKit

import SnapKit

final class CreateTodoViewController: UIViewController {
  
  // MARK: - Properties
  
  private let todoLabel = UIFactory.label("할일", textColor: .black)
  private let stateLabel = UIFactory.label("상태", textColor: .black)
  
  private let closeButton = UIFactory.plainButton("닫기", textColor: .black)
  private let saveButton = UIFactory.plainButton("저장", textColor: .black)
  private let deleteButton = UIFactory.plainButton("삭제", textColor: .red)
  
  private let progressButton = UIFactory.filledButton("진행")
  private let cancelButton = UIFactory.filledButton("취소")
  private let completedButton = UIFactory.filledButton("완료")
  private var stateButtonStack: UIStackView!
  
  private let textViewLine = UIFactory.separatorLine()
  
  private var titleTextView: UITextView!
  private let vcType: CreateTodoVCType
  private let storage = Storage.shared
  
  // MARK: - LifeCycle
  
  init(_ vcType: CreateTodoVCType) {
    self.vcType = vcType
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextView()
    setupButton()
    setupStyles()
    setupLayout()
    setupConstraints()
    updateUI()
  }
  
  // MARK: - Setup
  
  private func setupButton() {
    closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    progressButton.addTarget(self, action: #selector(didTapProgressButton), for: .touchUpInside)
    cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    completedButton.addTarget(self, action: #selector(didTapCompletedButton), for: .touchUpInside)
    deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    
    switch vcType {
    case .new:
      toggleStateButton(.progress)
      deleteButton.isHidden = true
    case .existed(let todo):
      toggleStateButton(todo.state)
    }
    
    let stack = UIStackView(arrangedSubviews: [progressButton, cancelButton, completedButton])
    stack.axis = .horizontal
    stack.spacing = 8
    self.stateButtonStack = stack
  }
  
  private func setupTextView() {
    let textView = UITextView()
    textView.isScrollEnabled = false
    textView.backgroundColor = .white
    textView.textColor = .black
    textView.font = .systemFont(ofSize: 18, weight: .regular)
    textView.delegate = self
    self.titleTextView = textView
  }
  
  private func setupStyles() {
    view.backgroundColor = .white
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
  }
  
  private func setupLayout() {
    [todoLabel, titleTextView, textViewLine, stateLabel, stateButtonStack, deleteButton]
      .forEach { view.addSubview($0) }
  }
  
  private func setupConstraints() {
    todoLabel.snp.makeConstraints { make in
      make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
    }
    
    titleTextView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(todoLabel.snp.bottom).offset(8)
    }
    
    textViewLine.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(titleTextView.snp.bottom)
      make.height.equalTo(1)
    }
    
    stateLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(textViewLine.snp.bottom).offset(42)
    }
    
    stateButtonStack.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(stateLabel.snp.bottom).offset(16)
    }
    
    deleteButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
    }
  }
  
  // MARK: - Selectors
  
  @objc private func didTapProgressButton() {
    toggleStateButton(.progress)
  }
  
  @objc private func didTapCancelButton() {
    toggleStateButton(.cancel)
  }
  
  @objc private func didTapCompletedButton() {
    toggleStateButton(.completed)
  }
  
  @objc private func didTapCloseButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func didTapSaveButton() {
    let title = titleTextView.text!
    var state: State
    
    if progressButton.isSelected {
      state = .progress
    } else if cancelButton.isSelected {
      state = .cancel
    } else {
      state = .completed
    }
    
    switch vcType {
    case .new:
      let todo = Todo(title: title, state: state)
      storage.create(todo)
    case .existed(var todo):
      todo.state = state
      todo.title = title
      storage.update(todo)
    }
    
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func didTapDeleteButton() {
    switch vcType {
    case .new:
      break
    case .existed(let todo):
      storage.delete(todo)
    }
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Helpers
  
  private func toggleStateButton(_ state: State) {
    switch state {
    case .progress:
      progressButton.isSelected = true
      cancelButton.isSelected = false
      completedButton.isSelected = false
    case .cancel:
      progressButton.isSelected = false
      cancelButton.isSelected = true
      completedButton.isSelected = false
    case .completed:
      progressButton.isSelected = false
      cancelButton.isSelected = false
      completedButton.isSelected = true
    }
  }
  
  private func updateUI() {
    switch vcType {
    case .new:
      saveButton.isEnabled = false
    case .existed(let todo):
      titleTextView.text = todo.title
      toggleStateButton(todo.state)
    }
  }
}

// MARK: - TextView Delegate

extension CreateTodoViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    if textView.text.count == 0 {
      saveButton.isEnabled = false
    } else {
      saveButton.isEnabled = true
    }
  }
}
