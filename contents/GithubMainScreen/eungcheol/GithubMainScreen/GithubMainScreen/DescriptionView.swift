import UIKit

import SnapKit

final class DescriptionView: UIView {
  
  // MARK: - Properties
  
  var imageView: UIImageView!
  var label: UILabel!
  
  let symbol: DescriptionSymbol
  
  // MARK: - LifeCycle
  
  init(_ symbol: DescriptionSymbol) {
    self.symbol = symbol
    super.init(frame: .zero)
    setupComponents()
    setupLayout()
    setupConstrinats()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  
  private func setupComponents() {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: symbol.imageName)?.withRenderingMode(.alwaysTemplate)
    imageView.contentMode = .center
    imageView.tintColor = .darkGray
    self.imageView = imageView
    
    let label = UILabel()
    label.text = symbol.description
    switch symbol {
    case .building:
      label.textColor = .white
      label.font = .systemFont(ofSize: 14, weight: .regular)
    case .location:
      label.textColor = .darkGray
      label.font = .systemFont(ofSize: 14, weight: .medium)
    case .link, .email:
      label.textColor = .white
      label.font = .systemFont(ofSize: 16, weight: .heavy)
    case .person:
      label.textColor = .darkGray
      label.font = .systemFont(ofSize: 14, weight: .medium)
      let attributedString = NSMutableAttributedString(string: symbol.description)
      let targetRange1 = (symbol.description as NSString).range(of: "15")
      let targetRange2 = (symbol.description as NSString).range(of: "14")
      [targetRange1, targetRange2].forEach {
        attributedString.addAttributes([
          .foregroundColor: UIColor.white,
          .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], range: $0)
      }
      label.attributedText = attributedString
    }
    self.label = label
  }
  
  private func setupLayout() {
    [imageView, label]
      .forEach { addSubview($0) }
  }
  
  private func setupConstrinats() {
    self.snp.makeConstraints { make in
      make.height.equalTo(label.intrinsicContentSize.height)
    }
    
    imageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(16)
      make.width.height.equalTo(16)
    }
    
    label.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(44)
    }
  }
}
