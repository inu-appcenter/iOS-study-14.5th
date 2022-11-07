//
//  MyWorkCellTableViewCell.swift
//  GitHubMainUI
//
//  Created by 정지훈 on 2022/11/04.
//

import UIKit

class MyWorkCell: UITableViewCell {

    @IBOutlet weak var ivMyWork: UIImageView!
    @IBOutlet weak var lbMyWork: UILabel!
    
    func configure(_ data: MyWorkModel) {
        ivMyWork.layer.cornerRadius = 5
        ivMyWork.image = UIImage(systemName: data.imageName)
        ivMyWork.backgroundColor = data.colorName
        lbMyWork.text = data.name
    }
}
