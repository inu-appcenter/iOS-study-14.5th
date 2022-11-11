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
  
  static func label(_ text: String, textColor: UIColor, font: UIFont? = .systemFont(ofSize: 16, weight: .bold)) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = textColor
    label.font = font
    return label
  }
  
  static func separatorLine() -> UIView {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }
  
  static func plainButton(_ text: String, textColor: UIColor) -> UIButton {
    var config = UIButton.Configuration.plain()
    var attText = AttributedString(text)
    attText.foregroundColor = textColor
    config.attributedTitle = attText
    
    let handler: UIButton.ConfigurationUpdateHandler = { button in
      var config = button.configuration
      switch button.state {
      case .disabled:
        config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
          var newAttr = attr
          newAttr.foregroundColor = .lightGray
          return newAttr
        }
        button.configuration = config
      default: break
      }
    }
    let button = UIButton(configuration: config)
    button.configurationUpdateHandler = handler
    return button
  }
}
