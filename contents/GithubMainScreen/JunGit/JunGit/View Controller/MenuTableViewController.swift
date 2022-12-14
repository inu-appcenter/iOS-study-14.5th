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
    private func configureUI() {
        self.configureTableView()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private Functions
private extension MenuTableViewController {
    func configureTableView() {
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0)
    }
    
    func registerNib() {
        let nib = UINib(nibName: K.FileName.menuTableViewCell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: MenuTableViewCell.identifier)
    }
}
