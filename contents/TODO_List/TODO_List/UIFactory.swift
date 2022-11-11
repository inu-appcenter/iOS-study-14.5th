import UIKit

final class UIFactory {
  static func createTodoButton() -> UIButton {
    var config = UIButton.Configuration.tinted()
    var container = AttributeContainer()
    container.foregroundColor = .gray
    config.attributedTitle = AttributedString("+ 새로운 일", attributes: container)
    config.baseBackgroundColor = .lightGray
    config.titleAlignment = .leading
    
    return UIButton(configuration: config)
  }
  
  static func label(_ text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = .black
    label.font = .systemFont(ofSize: 16, weight: .bold)
    return label
  }
  
  static func separatorLine() -> UIView {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }
}
