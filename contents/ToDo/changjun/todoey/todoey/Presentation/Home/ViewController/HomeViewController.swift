//
//  ViewController.swift
//  todoey
//
//  Created by 이창준 on 2022/11/08.
//

import UIKit

import SnapKit
import Then

class HomeViewController: UIViewController {

    // MARK: - UI Components
    lazy var profileView = ProfileView().then {
        $0.layer.cornerRadius = 22
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureUI()
    }
}

// MARK: - Configure
private extension HomeViewController {
    func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        self.configureNavigationBar()
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        self.view.addSubview(profileView)
    }
    
    func configureConstraints() {
        self.profileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(250)
        }
    }
    
    func configureStyles() {
        self.profileView.clipsToBounds = true
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        if let safeAreaTopInset = self.navigationController?.navigationBar.frame.size.height {
            self.additionalSafeAreaInsets = UIEdgeInsets(
                top: -safeAreaTopInset,
                left: 0, bottom: 0, right: 0)
        }
        
        let preferenceButton = UIButton().then {
            $0.setImage(SF.Navigation.preference.iconImage, for: .normal)
            $0.tintColor = .black
        }
        let addButton = UIButton().then {
            $0.setImage(SF.Navigation.add.iconImage, for: .normal)
            $0.tintColor = .black
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: preferenceButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct HomeViewControllerPreView: PreviewProvider {
  static var previews: some View {
    HomeViewController().toPreview()
  }
}
#endif
