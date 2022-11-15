//
//  ToDoListCell.swift
//  TodoList
//
//  Created by 정지훈 on 2022/11/11.
//

import UIKit

class ToDoListCell: UITableViewCell {

    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(_ data: ToDoListModel) {
        lbText.text = data.text
        lbTitle.text = data.title
        lbDate.text = data.day
    }

}
