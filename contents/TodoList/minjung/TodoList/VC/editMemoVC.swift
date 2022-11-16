//
//  editMemoVC.swift
//  TodoList
//
//  Created by 김민정 on 2022/11/14.
//

import Foundation
import UIKit

class editMemoVC:UIViewController {
    
    var data: MemoInfo?
    var delegate : sendUpdateDelegate?
    @IBOutlet weak var editStackView: UIStackView!
    @IBOutlet weak var memoTitle: UITextField!
    @IBOutlet weak var memoContent: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateMemo()
    }
    
    @IBAction func savingEdit(){
        
        var updatedMemo = MemoInfo(memotitle: memoTitle.text ?? "", memocontent: memoContent.text ?? "",memodate: DateType2String())
        updatedMemo.identifier = data?.identifier
       
        
        delegate?.sendData(data: updatedMemo)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func updateMemo(){
        memoTitle.text = data?.title
        memoContent.text = data?.content
    }
    
    
}

protocol sendUpdateDelegate{
    func sendData(data:MemoInfo)
}
