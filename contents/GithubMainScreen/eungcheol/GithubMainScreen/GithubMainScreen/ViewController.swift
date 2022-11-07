import UIKit

import Then
import SnapKit

final class ViewController: BaseViewController {
  
  // MARK: - Properties
  
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  
  private let profileImageView = UIImageView().then {
    $0.backgroundColor = .systemPink
    $0.layer.cornerRadius = 35
  }
  
  private let nameStack = UIStackView().then {
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
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(idLabel)
    $0.axis = .vertical
  }
  
  private let descriptionLabel = UILabel().then {
    $0.text = "반갑습니다 iOS개발자 김응철입니다."
    $0.font = .systemFont(ofSize: 16, weight: .bold)
    $0.textColor = .white
    $0.numberOfLines = 0
  }
  
  private let descriptionViewStack = UIStackView().then { stack in
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
  
  private let menuViewStack = UIStackView().then { stack in
    var menuViews: [MenuView] = []
    MenuSymbol.allCases.forEach {
      let menuView = MenuView(symbol: $0)
      menuViews.append(menuView)
    }
    menuViews.forEach {
      stack.addArrangedSubview($0)
    }
    stack.axis = .vertical
  }
  
  private let pinnedStack = UIStackView().then { stack in
    let pinnedImage = UIImageView(image: UIImage(systemName: "pin")?.withRenderingMode(.alwaysTemplate)).then {
      $0.tintColor = .darkGray
      $0.preferredSymbolConfiguration = .init(pointSize: 12)
    }
    let pinnedLabel = UILabel().then {
      $0.text = "Pinned"
      $0.textColor = .darkGray
      $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    stack.addArrangedSubview(pinnedImage)
    stack.addArrangedSubview(pinnedLabel)
    stack.axis = .horizontal
    stack.spacing = 12
  }
  
  private lazy var pinnedCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionView.pinnedCollectionViewLayout()
  ).then {
    $0.decelerationRate = .normal
    $0.register(PinnedCell.self, forCellWithReuseIdentifier: PinnedCell.identifier)
    $0.showsHorizontalScrollIndicator = false
    $0.backgroundColor = .black
    $0.dataSource = self
    $0.delegate = self
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
    [profileImageView, nameStack, descriptionLabel, descriptionViewStack, menuViewStack, pinnedStack, pinnedCollectionView]
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
    
    menuViewStack.snp.makeConstraints { make in
      make.top.equalTo(descriptionViewStack.snp.bottom).offset(24)
      make.leading.trailing.equalToSuperview()
    }
    
    pinnedStack.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.equalTo(menuViewStack.snp.bottom).offset(24)
    }
    
    pinnedCollectionView.snp.makeConstraints { make in
      make.top.equalTo(pinnedStack.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(120)
      make.bottom.equalToSuperview()
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

// MARK: - CollectionView Setup

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 5
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: PinnedCell.identifier, for: indexPath
    ) as? PinnedCell else {
      return UICollectionViewCell()
    }
    
    return cell
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
