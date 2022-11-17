//
//  CreateViewController.swift
//  TodoList
//
//  Created by 정지훈 on 2022/11/11.
//

import UIKit

class CreateViewController: UIViewController {
    
    
    @IBOutlet weak var tvText: UITextView!
    @IBOutlet weak var tfTitle: UITextField!
    
    var isEdit: Bool = false
    
    var getIndex: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8751700521, green: 0.6127229929, blue: 0, alpha: 1)
        
        editUIUpdate()
        btnDeleteAdd()
        textViewKeyboardLayout()
        
    }
    
    
    
    //MARK: - EditViewSetUp
    func editUIUpdate() {
        if let indexPath = getIndex {
            tvText.text = list[indexPath.item].text
            tfTitle.text = list[indexPath.item].title
            isEdit = true
        }
    }
    
    func btnDeleteAdd() {
        if isEdit {
            let btnDelete = UIBarButtonItem(
                image: UIImage(systemName: "trash.circle"),
                style: .plain,
                target: self, action: #selector(btnDeleteTouched(_:)))
            self.navigationItem.rightBarButtonItems?.append(btnDelete)
        }
    }
    
    //MARK: - buttonAction
    @objc func btnDeleteTouched(_ sender: UIBarButtonItem) {
        let indexPath = getIndex!
        if let data = UserDefaults.standard.data(forKey: "items") {
            var getList = (try? PropertyListDecoder().decode([ToDoListModel].self, from: data)) ?? [ToDoListModel]()
            getList.remove(at: indexPath.item)
            list = getList
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey: "items")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveTouched(_ sender: UIBarButtonItem) {
        let title = tfTitle.text ?? ""
        let text = tvText.text ?? ""
        let date = getDate()
        
        if title != "" || text != "" {
            let item = ToDoListModel(title: title, text: text, day: date)
            
            if isEdit {
                let indexPath = getIndex!
                list[indexPath.item] = item
            } else {
                list.append(item)
            }
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(list), forKey: "items")
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - TypeCasting
    func getDate() -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy.M.dd"
        
        let date = dataFormatter.string(from: Date())
        return date
    }
    
    //MARK: - keyboardLayout
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
    func textViewKeyboardLayout() {
        view.keyboardLayoutGuide.topAnchor.constraint(equalTo: tvText.bottomAnchor).isActive = true
    }
}

