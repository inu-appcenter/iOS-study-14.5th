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
  
  static func label(_ text: String, textColor: UIColor, font: UIFont? = .systemFont(ofSize: 24, weight: .bold)) -> UILabel {
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
      default:
        config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
          var newAttr = attr
          newAttr.foregroundColor = textColor
          return newAttr
        }
      }
      button.configuration = config
    }
    let button = UIButton(configuration: config)
    button.configurationUpdateHandler = handler
    return button
  }
  
  static func filledButton(_ text: String) -> UIButton {
    var config = UIButton.Configuration.tinted()
    config.baseBackgroundColor = .white
    config.background.strokeWidth = 1
    config.background.strokeColor = .lightGray
    config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
    var attText = AttributedString(text)
    attText.foregroundColor = .black
    config.attributedTitle = attText
    
    let handler: UIButton.ConfigurationUpdateHandler = { button in
      var config = button.configuration
      switch button.state {
      case .selected:
        config?.baseBackgroundColor = .black
        config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
          var newAttr = attr
          newAttr.foregroundColor = .white
          return newAttr
        }
      default:
        config?.baseBackgroundColor = .white
        config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
          var newAttr = attr
          newAttr.foregroundColor = .black
          return newAttr
        }
      }
      button.configuration = config
    }
    let button = UIButton(configuration: config)
    button.configurationUpdateHandler = handler
    return button
  }
}
