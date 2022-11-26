//
//  HomeCoordinator.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: CustomNavigationController
    var childCoordinators: [Coordinator] = []
    var homeViewController: HomeViewController
    
    // MARK: - Initializer
    init(_ navigationController: CustomNavigationController) {
        self.navigationController = navigationController
        self.homeViewController = HomeViewController()
    }
    
    // MARK: - Functions
    func start() {
        self.homeViewController.viewModel = HomeViewModel(
            coordinator: self,
            homeUseCase: self.createHomeUseCase()
        )
        self.navigationController.pushViewController(self.homeViewController, animated: true)
    }
    
    func showCreateFlow() {
        let createCoordinator = EditCoordinator.init(self.navigationController)
        createCoordinator.finishDelegate = self
        self.childCoordinators.append(createCoordinator)
        createCoordinator.pushCreateViewController(with: .create)
    }
    
    func showEditFlow(data: ToDo) {
        let editCoordinator = EditCoordinator.init(self.navigationController)
        editCoordinator.finishDelegate = self
        self.childCoordinators.append(editCoordinator)
        editCoordinator.pushEditViewController(with: .update, data: data)
    }
    
    func showOnboardFlow() {
        let onboardCoordinator = OnboardCoordinator.init(self.navigationController)
        onboardCoordinator.finishDelegate = self
        self.childCoordinators.append(onboardCoordinator)
        onboardCoordinator.start()
    }
}

// MARK: - Private Functions
private extension HomeCoordinator {
    func createHomeUseCase() -> HomeUseCase {
        return HomeUseCase()
    }
}

// MARK: - Finish Delegate
extension HomeCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinator.navigationController.popViewController(animated: true)
        self.homeViewController.viewModel?.syncViewModel()
        self.homeViewController.requestRefresh()
    }
}
