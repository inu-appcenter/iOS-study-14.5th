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
    
    // MARK: - Properties
    private var viewModel = HomeViewModel()

    // MARK: - UI Components
    lazy var profileView = ProfileView().then {
        $0.layer.cornerRadius = 22
    }
    
    lazy var summaryView = SummaryView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var dateSelectorView = DateSelectorView().then {
        $0.backgroundColor = .systemPink
    }
    
    lazy var toDoView = ToDoView().then {
        $0.delegate = self
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
        self.configureNavigationBar()
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [profileView, summaryView, dateSelectorView, toDoView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.profileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(250)
        }
        self.summaryView.snp.makeConstraints { make in
            make.top.equalTo(self.profileView.snp.bottom)
            make.leading.equalTo(self.profileView.snp.leading)
            make.trailing.equalTo(self.profileView.snp.trailing)
            make.height.equalTo(100)
        }
        self.dateSelectorView.snp.makeConstraints { make in
            make.top.equalTo(self.summaryView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        self.toDoView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.dateSelectorView.snp.bottom).offset(12)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
        self.profileView.clipsToBounds = true
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        if let safeAreaTopInset = self.navigationController?.navigationBar.frame.size.height {
            self.additionalSafeAreaInsets = UIEdgeInsets(
                top: -safeAreaTopInset,
                left: 0, bottom: 0, right: 0)
        }
        
        let menuButton = UIButton().then {
            $0.setImage(SF.Navigation.menu.iconImage, for: .normal)
            $0.tintColor = .black
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
}

// MARK: - ToDoViewDelegate
extension HomeViewController: ToDoViewDelegate {
    func showEditView(from view: ToDoView) {
        let vc = EditViewController()
        vc.dismissClosure = {
            self.viewModel.syncToDoData()
            self.toDoView.todoCollectionView.reloadData()
        }
        self.navigationController?.present(vc, animated: true)
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
