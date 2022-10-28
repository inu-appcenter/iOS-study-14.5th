//
//  ProfileCollectionViewCell.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/26.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let iconSize: CGSize = CGSize(width: 16, height: 16)
    static let padding: CGFloat = 8
    static let widthPadding: CGFloat = 30
    static let height: CGFloat = 25

    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var profileIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
