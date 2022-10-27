import UIKit

import SnapKit
import Then

final class MenuView: UIView {
  
  private lazy var imageView = UIImageView().then {
    $0.image = UIImage(systemName: symbol.imageName)?.withRenderingMode(.alwaysTemplate)
    $0.tintColor = .white
    $0.contentMode = .center
    $0.layer.cornerRadius = 10
    
    switch symbol {
    case .repositories:
      $0.backgroundColor = .gray
    case .starred:
      $0.backgroundColor = .systemYellow
    case .organizations:
      $0.backgroundColor = .orange
    }
  }
  
  private lazy var descriptionLabel = UILabel().then {
    $0.textColor = .white
    $0.text = symbol.description
    $0.font = .systemFont(ofSize: 16, weight: .regular)
  }
  
  private lazy var numberLabel = UILabel().then {
    $0.textColor = .gray
    $0.text = symbol.number
    $0.font = .systemFont(ofSize: 14, weight: .regular)
  }
  
  private lazy var arrowButton = UIButton().then {
    $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 14), forImageIn: .normal)
    $0.tintColor = .gray
  }
  
  let symbol: MenuSymbol
  
  // MARK: - LifeCycle
  
  init(symbol: MenuSymbol) {
    self.symbol = symbol
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupStyles()
    setupLayout()
    setupConstraints()
  }
  
  // MARK: - Setup
  
  private func setupStyles() {
    backgroundColor = .placeholderText
    layer.addBorder([.top, .bottom], color: .darkGray, width: 0.3)
  }
  
  private func setupLayout() {
    [imageView, descriptionLabel, numberLabel, arrowButton]
      .forEach { addSubview($0) }
  }
  
  private func setupConstraints() {
    self.snp.makeConstraints { make in
      make.height.equalTo(55)
    }
    
    imageView.snp.makeConstraints { make in
      make.width.height.equalTo(35)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(16)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(imageView.snp.trailing).offset(16)
    }
    
    arrowButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(16)
      make.centerY.equalToSuperview()
    }
    
    numberLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalTo(arrowButton.snp.leading).offset(-8)
    }
  }
}
