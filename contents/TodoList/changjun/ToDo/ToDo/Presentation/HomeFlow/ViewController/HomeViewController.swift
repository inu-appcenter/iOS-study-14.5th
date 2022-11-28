//
//  HomeViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import UIKit

import Hero
import SnapKit
import SwipeCellKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: HomeViewModel?
    
    // MARK: - UI Components
    private lazy var profileView: ProfileView = {
        let profileView = ProfileView()
        profileView.viewModel = ProfileViewModel()
        profileView.bindViewModel()
        profileView.layer.cornerRadius = 22
        profileView.clipsToBounds = true
        profileView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(250)
        }
        return profileView
    }()
    
    private lazy var summaryView: SummaryView = {
        let summaryView = SummaryView()
        summaryView.viewModel = SummaryViewModel(
            parentViewModel: self.viewModel
        )
        summaryView.bindViewModel()
        summaryView.backgroundColor = .clear
        summaryView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        return summaryView
    }()
    
    private lazy var dateSelectorView: DateSelectorView = {
        let dateSelectorView = DateSelectorView()
        dateSelectorView.viewModel = DateSelectorViewModel(
            dateSelectorUseCase: DateSelectorUseCase()
        )
        dateSelectorView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        return dateSelectorView
    }()
    
    private lazy var todoView: ToDoView = {
        let view = ToDoView()
        view.viewModel = ToDoViewModel(
            todoUseCase: ToDoUseCase(),
            parentViewModel: self.viewModel
        )
        view.backgroundColor = .tdGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        view.delegate = self
        view.hero.id = HeroID.Home2Edit.todoViewTransition
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.viewModel?.validateAuth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.syncWithServer()
        self.profileView.refresh()
    }
    
    // MARK: - Functions
    func requestRefresh() {
        self.todoView.refresh()
    }
}

// MARK: - UI Configuration
private extension HomeViewController {
    func configureUI() {
        self.configureNavigationBar()
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        if let safeAreaTopInset = self.navigationController?.navigationBar.frame.size.height {
            self.additionalSafeAreaInsets = UIEdgeInsets(
                top: -safeAreaTopInset,
                left: 0, bottom: 0, right: 0)
        }
        
        let menuButton: UIButton = {
            let button = UIButton()
            button.setImage(SFSymbol.menu, for: .normal)
            button.tintColor = .black
            return button
        }()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    func configureLayout() {
        [profileView, summaryView, dateSelectorView, todoView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.profileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        self.summaryView.snp.makeConstraints { make in
            make.top.equalTo(self.profileView.snp.bottom)
            make.leading.trailing.equalTo(self.profileView)
        }
        self.dateSelectorView.snp.makeConstraints { make in
            make.top.equalTo(self.summaryView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        self.todoView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.dateSelectorView.snp.bottom).offset(12)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
    }
}

extension HomeViewController: ToDoDelegate {
    func addButtonDidTap() {
        self.viewModel?.addButtonDidTap()
    }
    
    func cellDidLongPressed(with todo: ToDo) {
        self.viewModel?.coordinator?.showEditFlow(data: todo)
    }
}
