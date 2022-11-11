import UIKit

import SnapKit

final class CreateTodoViewController: UIViewController {
  
  // MARK: - Properties
  
  private let todoLabel = UIFactory.label("할일", textColor: .black)
  private let stateLabel = UIFactory.label("상태", textColor: .black)
  private let closeButton = UIFactory.plainButton("닫기", textColor: .black)
  private let saveButton = UIFactory.plainButton("저장", textColor: .black)
  private let textViewLine = UIFactory.separatorLine()
  
  private var titleTextView: UITextView!
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextView()
    setupStyles()
    setupLayout()
    setupConstraints()
    setupButton()
  }
  
  // MARK: - Setup
  
  private func setupButton() {
    closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    saveButton.isEnabled = false
  }

  private func setupTextView() {
    let textView = UITextView()
    textView.isScrollEnabled = false
    textView.backgroundColor = .white
    textView.textColor = .black
    textView.font = .systemFont(ofSize: 18, weight: .regular)
    self.titleTextView = textView
  }
  
  private func setupStyles() {
    view.backgroundColor = .white
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
  }
  
  private func setupLayout() {
    [todoLabel, titleTextView, textViewLine]
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
  }
  
  // MARK: - Selectors
  
  @objc private func didTapCloseButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func didTapSaveButton() {
    
  }
}
