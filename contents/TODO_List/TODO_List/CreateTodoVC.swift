import UIKit

import SnapKit

final class CreateTodoViewController: UIViewController {
  
  // MARK: - Properties
  
  private let todoLabel = UIFactory.label("할일", textColor: .black)
  private let stateLabel = UIFactory.label("상태", textColor: .black)
  private let closeButton = UIFactory.plainButton("닫기", textColor: .black)
  private let saveButton = UIFactory.plainButton("저장", textColor: .black)
  
  private var titleTextView: UITextView!
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextView()
    setupStyles()
  }
  
  // MARK: - Setup

  private func setupTextView() {
    let textView = UITextView()
    textView.isScrollEnabled = false
    self.titleTextView = textView
  }
  
  private func setupStyles() {
    view.backgroundColor = .white
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    saveButton.isEnabled = false
  }
  
  private func setupLayout() {
  }
  
  private func setupConstraints() {
    
  }
  
  // MARK: - Selectors
  
  @objc private func didTapCloseButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func didTapSaveButton() {
    
  }
}
