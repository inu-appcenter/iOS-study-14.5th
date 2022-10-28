//
//  MenuTableViewController.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/28.
//

import UIKit

class MenuTableViewController: UITableViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    // MARK: - UI
    func configureUI() {
        self.registerNib()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell

        cell.iconImageView.image = UIImage(systemName: Menu.allCases[indexPath.item].iconImage)
        cell.iconBackgroundView.backgroundColor = Menu.allCases[indexPath.item].backgroundColor
        cell.menuLabel.text = Menu.allCases[indexPath.item].menuLabel
        cell.numberOfContentsLabel.text = String(Menu.allCases[indexPath.item].numberOfContents)

        return cell
    }
}

// MARK: - Private Functions
private extension MenuTableViewController {
    func registerNib() {
        let nib = UINib(nibName: K.FileName.menuTableViewCell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: MenuTableViewCell.identifier)
    }
}
