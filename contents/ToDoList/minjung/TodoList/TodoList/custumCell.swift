//
//  custumcCell.swift
//  TodoList
//
//  Created by 김민정 on 2022/11/08.
//

import UIKit

class custumCell:UITableViewCell{
    
    var deleteCallBackMethod: (() -> Void)?
    var updateCallBackMethod: (() -> Void)?
    
    var id: Int?
    @IBOutlet weak var memoTitle : UILabel!
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var editBtn : UIButton!
    
    @IBAction func deleteMemo(_ sender: Any) {
        
       deleteCallBackMethod?()
        
    }
    
    @IBAction func updateMemo(_ sender: Any) {
        updateCallBackMethod?()
    }
    
    

    func updateCell(memo:MemoInfo){
        memoTitle.text = memo.title
        date.text = memo.date
        id = memo.identifier
        
    }
    
    
}
