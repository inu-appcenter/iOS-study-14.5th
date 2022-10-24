//
//  ViewController.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/19.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    // Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    // Navigation Bar
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    // Profile Header
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileIdLabel: UILabel!
    // Profile Message
    @IBOutlet weak var profileMessageLabel: UILabel!
    
    @IBOutlet var profileDetails: [ProfileDetailsView]!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }

    // MARK: - IBActions
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        print("Setting Button Tapped")
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        print("Share Button Tapped")
    }
}

// MARK: - UI
private extension ViewController {
    func configureUI() {
        self.profileLabel.text = K.userName
        self.settingButton.setImage(
            UIImage(systemName: K.Icon.settingsIcon),
            for: .normal)
        self.shareButton.setImage(
            UIImage(systemName: K.Icon.shareIcon),
            for: .normal)
        
        for (index, view) in self.profileDetails.enumerated() {
            view.iconImageView.image = UIImage(systemName: ProfileData.icons[index])
            view.textLabel.text = ProfileData.datas[index]
        }
    }
}
