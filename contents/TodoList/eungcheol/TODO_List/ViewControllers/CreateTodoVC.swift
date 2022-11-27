import UIKit

import SnapKit
import Then

final class CreateTodoViewController: UIViewController {
  
  // MARK: - Properties
  
  private let todoLabel = UIFactory.label("할일", textColor: .black)
  private let stateLabel = UIFactory.label("상태", textColor: .black)
  private let closeButton = UIFactory.plainButton("닫기", textColor: .black)
  private let saveButton = UIFactory.plainButton("저장", textColor: .black)
  private let deleteButton = UIFactory.plainButton("삭제", textColor: .red)
  private let completedButton = UIFactory.filledButton("완료")
  private let textViewLine = UIFactory.separatorLine()
  
  private lazy var contentsTextView = UITextView().then {
    $0.isScrollEnabled = false
    $0.backgroundColor = .white
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 18, weight: .regular)
    $0.delegate = self
  }
  
  private let indicator = UIActivityIndicatorView().then {
    $0.color = .gray
  }
  
  private let vcType: CreateTodoVCType
  private var currentTodo: Todo!
  private let service = TodoService.instance
  
  // MARK: - LifeCycle
  
  init(_ vcType: CreateTodoVCType) {
    self.vcType = vcType
    switch vcType {
    case .new:
      break
    case .existed(let todo):
      self.currentTodo = todo
    }
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupStyles()
    setupLayout()
    setupConstraints()
    updateUI()
    
    closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    completedButton.addTarget(self, action: #selector(didTapCompletedButton), for: .touchUpInside)
    deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
  }
  
  // MARK: - Setup
  
  private func setupStyles() {
    view.backgroundColor = .white
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    
    switch vcType {
    case .new: deleteButton.isHidden = true
    default: break
    }
  }
  
  private func setupLayout() {
    [todoLabel, contentsTextView, textViewLine, stateLabel, completedButton, deleteButton, indicator]
      .forEach { view.addSubview($0) }
  }
  
  private func setupConstraints() {
    todoLabel.snp.makeConstraints { make in
      make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
    }
    
    contentsTextView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(todoLabel.snp.bottom).offset(8)
    }
    
    textViewLine.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(contentsTextView.snp.bottom)
      make.height.equalTo(1)
    }
    
    stateLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(textViewLine.snp.bottom).offset(42)
    }
    
    completedButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(stateLabel.snp.bottom).offset(16)
    }
    
    deleteButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
    }
    
    indicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  // MARK: - Selectors
  
  @objc private func didTapCompletedButton() {
    completedButton.isSelected = !completedButton.isSelected
  }
  
  @objc private func didTapCloseButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func didTapSaveButton() {
    let contents = contentsTextView.text!
    let isCompleted = completedButton.isSelected
    
    let todo = TodoRequestDTO(contents: contents, isCompleted: isCompleted)
    indicator.startAnimating()
    
    switch vcType {
    case .new:
      service.createTodo(1, body: todo) { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
    case .existed:
      service.updateTodo(currentTodo.id, body: todo) { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
    }
  }
  
  @objc private func didTapDeleteButton() {
    indicator.startAnimating()
    switch vcType {
    case .new: break
    case .existed:
      service.deleteTodo(currentTodo.id) { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
    }
  }
  
  // MARK: - Helpers
  
  private func updateUI() {
    switch vcType {
    case .new:
      saveButton.isEnabled = false
    case .existed(let todo):
      contentsTextView.text = todo.contents
      completedButton.isSelected = todo.isCompleted
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
