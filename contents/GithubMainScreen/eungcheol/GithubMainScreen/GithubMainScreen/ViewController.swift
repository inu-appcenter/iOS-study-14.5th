import UIKit

import Then
import SnapKit

final class ViewController: BaseViewController {
  
  // MARK: - Properties
  
  private lazy var scrollView = UIScrollView()
  private lazy var contentView = UIView()
  private var nameLabel: UILabel!
  private var idLabel: UILabel!
  
  private lazy var profileImageView = UIImageView().then {
    $0.backgroundColor = .systemPink
    $0.layer.cornerRadius = 35
  }
  
  private lazy var nameStack = UIStackView().then {
    let nameLabel = UILabel().then {
      $0.text = "EungCheol Kim"
      $0.textColor = .white
      $0.font = .systemFont(ofSize: 24, weight: .heavy)
    }
    
    let idLabel = UILabel().then {
      $0.text = "eung7"
      $0.textColor = .darkGray
      $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    self.nameLabel = nameLabel
    self.idLabel = idLabel
    
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(idLabel)
    $0.axis = .vertical
  }
  
  private lazy var descriptionLabel = UILabel().then {
    $0.text = "반갑습니다 iOS개발자 김응철입니다."
    $0.font = .systemFont(ofSize: 16, weight: .bold)
    $0.textColor = .white
    $0.numberOfLines = 0
  }
  
  private lazy var descriptionViewStack = UIStackView().then { stack in
    var descriptionViews: [DescriptionView] = []
    DescriptionSymbol.allCases.forEach {
        let descriptionView = DescriptionView($0)
        descriptionViews.append(descriptionView)
    }
    
    descriptionViews.forEach {
      stack.addArrangedSubview($0)
    }
    stack.axis = .vertical
    stack.spacing = 8
  }
  
  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
  }
  
  // MARK: - Setup
  
  override func setupStyles() {
    view.backgroundColor = .black
  }
  
  override func setupLayouts() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    [profileImageView, nameStack, descriptionLabel, descriptionViewStack]
      .forEach { contentView.addSubview($0) }
  }
  
  override func setupConstraints() {
    scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalTo(scrollView.snp.width)
    }
    
    profileImageView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().inset(8)
      make.width.height.equalTo(70)
    }
    
    nameStack.snp.makeConstraints { make in
      make.leading.equalTo(profileImageView.snp.trailing).offset(16)
      make.centerY.equalTo(profileImageView)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(profileImageView.snp.bottom).offset(16)
      make.leading.equalToSuperview().inset(16)
    }
    
    descriptionViewStack.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
    }
  }
  
  private func setupNavigationBar() {
    let gearButton = UIButton()
    let shareButton = UIButton()
    gearButton.setImage(UIImage(systemName: NavigationSymbol.gear.imageName), for: .normal)
    shareButton.setImage(UIImage(systemName: NavigationSymbol.share.imageName), for: .normal)
    [gearButton, shareButton]
      .forEach { $0.setPreferredSymbolConfiguration(.init(pointSize: 24), forImageIn: .normal) }
    
    let buttonStack = UIStackView(arrangedSubviews: [gearButton, shareButton])
    buttonStack.axis = .horizontal
    buttonStack.spacing = 16
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonStack)
  }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ViewControllerPreView: PreviewProvider {
  static var previews: some View {
    ViewController().toPreview()
  }
}
#endif
