//
//  VC2.swift
//  TodoList
//
//  Created by 김민정 on 2022/11/08.
//

import UIKit


class newMemoVC : UIViewController {
    

    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var titletextField : UITextField!
    @IBOutlet weak var contentsTextView : UITextView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
        let memoInfo = MemoInfo(memotitle: titletextField.text ?? "", memocontent: contentsTextView.text ?? "", memodate: DateType2String())
        
        dummyMemoList.append(memoInfo)
    
        encoding()
        
        self.navigationController?.popToRootViewController(animated: true)
       
    }
    
    
    
    
}


