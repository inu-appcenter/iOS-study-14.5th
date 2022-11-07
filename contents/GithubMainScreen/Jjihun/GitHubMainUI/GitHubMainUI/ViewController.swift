//
//  ViewController.swift
//  GitHubMainUI
//
//  Created by 정지훈 on 2022/11/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nvItem: UINavigationItem!
    @IBOutlet weak var tableViewMyWork: UITableView!
    @IBOutlet weak var ivMyWork: UIImageView!
    @IBOutlet weak var buttonAddFavorite: UIButton!
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var shortcutsView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var buttonGetStarted: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfSearch: UITextField!
    
    let myWorkList: [MyWorkModel] = MyWorkModel.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfSearch.addLeftImage(image: UIImage(systemName: "magnifyingglass")!)
        tfSearch.placeholder = "Search GitHub"
        
        radiusSetUp()
        borderSetUp()
        nvItem.largeTitleDisplayMode = .automatic
        
        tableViewMyWork.delegate = self
        tableViewMyWork.dataSource = self
        
        scrollView.delegate = self
        
       
        
    }
    
    private func borderSetUp() {
        buttonAddFavorite.layer.borderWidth = 1
        buttonAddFavorite.layer.borderColor = UIColor.systemGray2.cgColor
        buttonGetStarted.layer.borderWidth = 1
        buttonGetStarted.layer.borderColor = UIColor.systemGray2.cgColor
        
    }
    
    private func radiusSetUp() {
        tableViewMyWork.layer.cornerRadius = 10
        tfSearch.layer.cornerRadius = 10
        buttonGetStarted.layer.cornerRadius = 4
        buttonAddFavorite.layer.cornerRadius = 4
        favoritesView.layer.cornerRadius = 4
        shortcutsView.layer.cornerRadius = 4
    }
    
}



extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWorkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyWorkCell", for: indexPath) as? MyWorkCell else {
            return UITableViewCell()
        }
        let data = myWorkList[indexPath.item]
        cell.configure(data)
        
        return cell
    }
    
    
}

extension UITextField {
    func addLeftImage(image: UIImage) {
        let leftImage = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        leftImage.image = image
        leftImage.tintColor = .gray
        self.leftView = leftImage
        self.leftViewMode = .always
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        
        if contentOffset >= 55 {
            nvItem.largeTitleDisplayMode = .never
            //let bound = navigationBar.bounds
            //navigationBar.frame = CGRect(x: 0, y: 0, width: bound.width, height: 50)
            //navigationBar.sizeThatFits(CGSize(width: bound.width, height: 50))
        }
        
        else if contentOffset < 55 {
            nvItem.largeTitleDisplayMode = .always
            //let bound = navigationBar.bounds
            //navigationBar.frame = CGRect(x: 0, y: 0, width: bound.width, height: 90)
            //navigationBar.sizeThatFits(CGSize(width: bound.width, height: 90))
        }
    }
}

