import UIKit

import SnapKit
import Then

final class TodoCell: UITableViewCell {
  
  // MARK: - Properties
  
  static let identifier = "TodoCell"
  
  private let titleLabel = UIFactory.label("", textColor: .black, font: .systemFont(ofSize: 18, weight: .regular)).then {
    $0.numberOfLines = 0
  }
    
  // MARK: - Setup
  
  func setupComponents(_ todo: Todo) {
    setupLayout()
    setupConstraints()
    
    titleLabel.text = todo.contents
    
    if todo.isCompleted {
      titleLabel.textColor = .lightGray
    } else {
      titleLabel.textColor = .black
    }
  }
  
  private func setupLayout() {
    contentView.addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview().inset(24)
    }
  }
}
