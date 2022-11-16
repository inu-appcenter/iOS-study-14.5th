//
//  ViewController.swift
//  TodoList
//
//  Created by 김민정 on 2022/11/08.
//

import UIKit

var dummyMemoList = [MemoInfo]()

class mainVC: UIViewController {
    
    
    @IBOutlet weak var mainTableView : UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainTableView.reloadData()
    }
    
    
   


}

//MARK: extension
extension mainVC: UITableViewDelegate,UITableViewDataSource,sendUpdateDelegate {
    
    //MARK: sendUpdateDelegate
    func sendData(data: MemoInfo)  {
        
        for (i,_) in dummyMemoList.enumerated(){
            
            if (dummyMemoList[i].identifier == data.identifier){
                
                dummyMemoList[i] = data
                encoding()
            }
    }
            
}
    
    //MARK: tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "custumCell", for: indexPath) as? custumCell else{
                return UITableViewCell()
        }
        
        
        cell.deleteCallBackMethod = {

            dummyMemoList = dummyMemoList.filter { $0.identifier != cell.id }
            encoding()
            self.mainTableView.reloadData()

        }
        
        cell.updateCallBackMethod = {
            
            guard let editVC  = self.storyboard?.instantiateViewController(withIdentifier: "editMemoVC") as? editMemoVC else{
                return
            }
            editVC.delegate = self
            
            editVC.data = dummyMemoList[indexPath.row]
            self.navigationController?.pushViewController(editVC, animated: true)
        }
        
        
       
        
        let memo = dummyMemoList[indexPath.row]
        cell.updateCell(memo: memo)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return dummyMemoList.count
    }
    
    
    
    
}

