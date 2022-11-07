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
    // Menu Table View
    @IBOutlet weak var tableContainerView: UIView!
    // Pinned Collection View
    @IBOutlet weak var pinnedContainerView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }
}

// MARK: - UI
private extension ViewController {
    func configureUI() {
        self.scrollView.delegate = self
        self.configureNavBar()
        self.configureProfileHeader()
        self.configureProfileStackView()
        self.configureProfileCollectionView()
        self.configurePinnedContainerView()
    }
    
    func configureNavBar() {
        self.navigationItem.title = K.Profile.userID
        
        let settingButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: K.Icon.settingsIcon), for: .normal)
            button.setPreferredSymbolConfiguration(
                UIImage.SymbolConfiguration(pointSize: 20),
                forImageIn: .normal)
            return button
        }()
        let shareButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: K.Icon.shareIcon), for: .normal)
            button.setPreferredSymbolConfiguration(
                UIImage.SymbolConfiguration(pointSize: 20),
                forImageIn: .normal)
            return button
        }()
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.addArrangedSubview(settingButton)
            stackView.addArrangedSubview(shareButton)
            stackView.axis = .horizontal
            stackView.spacing = 16
            return stackView
        }()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stackView)
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
    
    func configureTableContainerView() {
        let storyboard = UIStoryboard(name: K.FileName.mainStoryboard, bundle: .main)
        if let vc = storyboard.instantiateViewController(
            withIdentifier: K.FileName.menuTableViewController) as? MenuTableViewController {
            self.addChild(vc)
            self.tableContainerView.addSubview(vc.view)
            vc.view.frame = self.tableContainerView.bounds
            vc.didMove(toParent: self)
        }
    }
    
    func configurePinnedContainerView() {
        let storyboard = UIStoryboard(name: K.FileName.mainStoryboard, bundle: .main)
        if let vc = storyboard.instantiateViewController(
            withIdentifier: K.FileName.pinnedCollectionViewController) as? PinnedCollectionViewController {
            self.addChild(vc)
            self.pinnedContainerView.addSubview(vc.view)
            vc.view.frame = self.pinnedContainerView.bounds
            let size = CGSize(
                width: self.pinnedContainerView.bounds.width - 12,
                height: self.pinnedContainerView.bounds.height)
            vc.collectionView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            vc.didMove(toParent: self)
        }
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
            constant: self.profileCollectionView.bounds.height + 20)
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
            cell.profileLabel.attributedText = Profile.allCases[indexPath.item].data.boldDecimals(
                size: 13,
                font: Profile.allCases[indexPath.item].font)
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
        let iconSize = ProfileCollectionViewCell.iconSize
        let padding: CGFloat = ProfileCollectionViewCell.padding
        let labelSize: CGSize = item.data.size(withAttributes: [
            NSAttributedString.Key.font: Profile.allCases[indexPath.item].font
        ])
        let totalSize = CGSize(
            width: iconSize.width + padding + labelSize.width + ProfileCollectionViewCell.widthPadding,
            height: ProfileCollectionViewCell.height)
        return totalSize
    }
}
