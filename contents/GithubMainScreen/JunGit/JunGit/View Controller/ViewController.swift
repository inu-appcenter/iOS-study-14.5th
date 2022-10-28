//
//  ViewController.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/19.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    // Scroll View
    @IBOutlet weak var scrollView: UIScrollView!

    // -- Navigation Bar --
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    // -- Profile --
    @IBOutlet weak var profileStackView: UIStackView!
    // Profile Header
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileIdLabel: UILabel!
    // Profile Message
    @IBOutlet weak var profileStatusLabel: UILabel!
    @IBOutlet weak var profileMessageLabel: UILabel!
    // Profile Collection View
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }

    // MARK: - IBActions
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        print("Setting Button Tapped")
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        print("Share Button Tapped")
    }
}

// MARK: - UI
private extension ViewController {
    
    func configureUI() {
        self.configureNavBar()
        self.configureProfileHeader()
        self.configureProfileStackView()
        self.configureProfileCollectionView()
    }
    
    func configureNavBar() {
        self.profileLabel.text = K.Profile.userID
        self.settingButton.setImage(
            UIImage(systemName: K.Icon.settingsIcon),
            for: .normal)
        self.shareButton.setImage(
            UIImage(systemName: K.Icon.shareIcon),
            for: .normal)
    }
    
    func configureProfileHeader() {
        self.profileImageView.image = UIImage(named: K.Profile.userImage)
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileNameLabel.text = K.Profile.userName
        self.profileIdLabel.text = K.Profile.userID
        self.profileStatusLabel.text = K.Profile.userStatus
        self.profileStatusLabel.layer.cornerRadius = self.profileStatusLabel.frame.height / 10
        self.profileMessageLabel.text = K.Profile.userMessage
    }
    
    func configureProfileStackView() {
        self.profileStackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        self.profileStackView.isLayoutMarginsRelativeArrangement = true
    }
}

// MARK: - Collection View
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureProfileCollectionView() {
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        self.registerNib()
        
        let heightConstraint = NSLayoutConstraint(
            item: self.profileCollectionView!,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: self.profileCollectionView.bounds.height)
        NSLayoutConstraint.activate([heightConstraint])
    }
    
    private func registerNib() {
        let nib = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        self.profileCollectionView.register(nib, forCellWithReuseIdentifier: K.Identifier.profileCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Profile.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.profileCollectionView.dequeueReusableCell(
            withReuseIdentifier: K.Identifier.profileCell,
            for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
        }
        if Profile.allCases[indexPath.item].data.contains("followers") {
            cell.profileLabel.attributedText = Profile.allCases[indexPath.item].data.boldDecimals(size: 15)
        } else {
            cell.profileLabel.text = Profile.allCases[indexPath.item].data
            cell.profileLabel.font = Profile.allCases[indexPath.item].font
        }
        cell.profileIconImageView.image = UIImage(systemName: Profile.allCases[indexPath.item].iconImage)
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = Profile.allCases[indexPath.item]
        let iconSize = CGSize(width: 16, height: 16)
        let padding: CGFloat = 8
        let labelSize: CGSize = item.data.size(withAttributes: [
            NSAttributedString.Key.font: Profile.allCases[indexPath.item].font
        ])
        let totalSize = CGSize(width: iconSize.width + padding + labelSize.width + 30, height: 25)
        return totalSize
    }
}
