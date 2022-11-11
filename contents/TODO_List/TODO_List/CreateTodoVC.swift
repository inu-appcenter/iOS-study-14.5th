import UIKit

import SnapKit

final class CreateTodoViewController: UIViewController {
  
  // MARK: - Properties
  
  private let todoLabel = UIFactory.label("할일")
  private let stateLabel = UIFactory.label("상태")
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
  }
  
  private func setupLayout() {
    
  }
  
  private func setupConstraints() {
    
  }
}
