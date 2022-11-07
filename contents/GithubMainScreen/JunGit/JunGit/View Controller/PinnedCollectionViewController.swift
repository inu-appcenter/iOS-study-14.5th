//
//  PinnedCollectionViewController.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

class PinnedCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        self.registerNib()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PinnedCollectionViewCell.identifier,
            for: indexPath) as! PinnedCollectionViewCell
        cell.ownerLabel.text = K.Profile.userID
        cell.ownerImageView.image = UIImage(named: K.Profile.userImage)
        cell.nameLabel.text = Pinned.allCases[indexPath.item].name
        cell.descriptionLabel.text = Pinned.allCases[indexPath.item].description
        cell.starredLabel.text = String(Pinned.allCases[indexPath.item].starred)
        cell.programLangLabel.text = Pinned.allCases[indexPath.item].language.rawValue
        cell.programLangDot.image = UIImage(
            systemName: K.Icon.dot)?
            .withTintColor(Pinned.allCases[indexPath.item].dotColor,
                           renderingMode: .alwaysOriginal)
        return cell
    }
    
}

extension PinnedCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
}

private extension PinnedCollectionViewController {
    func registerNib() {
        let nib = UINib(nibName: K.FileName.pinnedCollectionViewCell, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: PinnedCollectionViewCell.identifier)
    }
}
