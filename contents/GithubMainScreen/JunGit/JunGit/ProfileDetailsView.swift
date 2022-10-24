//
//  ProfileDetailsView.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/24.
//

import UIKit

final class ProfileDetailsView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromXib()
    }
}
