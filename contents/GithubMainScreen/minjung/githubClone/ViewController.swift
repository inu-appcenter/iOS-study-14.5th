//
//  ViewController.swift
//  githubClone
//
//  Created by 김민정 on 2022/11/01.
//

import UIKit




class ViewController: UIViewController{
    
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var profileView : UIImageView!

    

    

    //MARK: - tableViewValue
    let tabelViewArray : [String] = ["Repositories","Starred","Organization"]
    let tableViewNumArray : [String] = ["1","2","3"]
    let tabelViewImageArray : [String] = ["repositories","starred","organization"]
    
    
    //MARK: - collectionViewValue
    let collectionViewIdArray : [String] = ["poly9010","poly9010","poly9010","poly9010","poly9010","poly9010"]
    let collectionViewrepoNameArray : [String] = ["CS-Study","Python","JavaStudy","ReadingRecord","Algorithm","AppCenterProject"]
    let collectionViewCommentArray : [String] = ["💻 CS 전공지식을 정리하고 기술 면접을 함께 준비해요 😎","1학년 1학기 프로그래밍 입문","", "📚 함께 책을 읽고 정리하는 레포", "🌱 알고리즘을 풀어요.",""]
    let collectionViewforkArray : [String] = ["forked from CS-Free-study/CS-Study","","","forked from CS-Free-study/ReadingRecord","forked from CS-Free-study/Algorithm",""]
    let collectionViewstarArray : [String] = ["100","100","100","100","100","100"]
    let collectionViewlanguageArray : [String] = ["","Python","Java","","Python","Swift"]
    let collectionViewlanguageColorArray : [PLImageSet] = [.none,.python,.java,.none,.python,.swift]
    
    
    
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        profileView.layer.cornerRadius = profileView.frame.height/2
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        print("table View")
    }
    


}
//MARK: - TableView
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tabelViewArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "custumCell", for: indexPath) as? CustomCell else {
             return UITableViewCell()
         }
        
     
    
        
        cell.name.text = tabelViewArray[indexPath.row]
        cell.num.text = tableViewNumArray[indexPath.row]
        cell.icon.image = UIImage(named: tabelViewImageArray[indexPath.row])
        
        
        return cell
        
        
    }
}

//MARK: - CollectionView
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? collectionViewCell else {
             return UICollectionViewCell()
         }
        
        cell.collectionViewProfile.layer.cornerRadius = cell.collectionViewProfile.frame.height/2
        cell.layer.cornerRadius = 5.1
        cell.id.text = collectionViewIdArray[indexPath.item]
        cell.repoName.text = collectionViewrepoNameArray[indexPath.item]
        cell.comment.text = collectionViewCommentArray[indexPath.item]
        cell.forkInfo.text = collectionViewforkArray[indexPath.item]
        cell.star.text = collectionViewstarArray[indexPath.item]
        
        cell.language.text = collectionViewlanguageArray[indexPath.row]
        cell.languageImage.setColor(style : collectionViewlanguageColorArray[indexPath.item])
        

        
        return cell
    }
    
    
    
}


