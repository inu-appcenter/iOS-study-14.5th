//
//  PinnedCollectionViewCell.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

class PinnedCollectionViewCell: UICollectionViewCell {

    static let identifier = "PinnedCell"
    
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starredLabel: UILabel!
    @IBOutlet weak var programLangLabel: UILabel!
    @IBOutlet weak var programLangDot: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 4
        self.ownerImageView.layer.cornerRadius = self.ownerImageView.frame.width / 2
    }

}
