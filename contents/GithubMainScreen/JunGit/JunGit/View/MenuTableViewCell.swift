//
//  MenuTableViewCell.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    static let identifier = "MenuTableViewCell"

    // MARK: - IBOutlets
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var numberOfContentsLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.iconBackgroundView.layer.cornerRadius = self.iconImageView.frame.width / 3
    }

    // MARK: - Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
