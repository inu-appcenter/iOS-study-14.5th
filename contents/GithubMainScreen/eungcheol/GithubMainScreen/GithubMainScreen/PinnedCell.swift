import UIKit

import Then
import SnapKit

final class PinnedCell: UICollectionViewCell {

  // MARK: - Properties
  
  static let identifier = "PinnedCell"
  
  private let profileImageView = UIImageView().then {
    $0.backgroundColor = .yellow
    $0.layer.cornerRadius = 10
  }
  
  private let teamLabel = UILabel().then {
    $0.text = "eung7"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 12, weight: .medium)
  }
  
  private let repoTitleLabel = UILabel().then {
    $0.text = "GithubMainScreen"
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 18, weight: .bold)
  }
  
  private let repoDescriptionLabel = UILabel().then {
    $0.text = "깃허브 모바일 페이지 만들기"
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 16, weight: .medium)
  }
  
  private let starImageView = UIImageView().then {
    $0.preferredSymbolConfiguration = .init(pointSize: 12)
    $0.image = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
    $0.tintColor = .darkGray
  }
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupStyles()
    setupLayout()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  
  private func setupStyles() {
    backgroundColor = .placeholderText
    layer.cornerRadius = 5
  }
  
  private func setupLayout() {
    [profileImageView, teamLabel, repoTitleLabel, repoDescriptionLabel, starImageView]
      .forEach { contentView.addSubview($0) }
  }
  
  private func setupConstraints() {
    profileImageView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().inset(16)
      make.width.height.equalTo(20)
    }
    
    teamLabel.snp.makeConstraints { make in
      make.centerY.equalTo(profileImageView)
      make.leading.equalTo(profileImageView.snp.trailing).offset(8)
    }
    
    repoTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.equalTo(profileImageView.snp.bottom).offset(8)
    }
    
    repoDescriptionLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.equalTo(repoTitleLabel.snp.bottom).offset(4)
    }
    
    starImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.equalTo(repoDescriptionLabel.snp.bottom).offset(8)
    }
  }
}
