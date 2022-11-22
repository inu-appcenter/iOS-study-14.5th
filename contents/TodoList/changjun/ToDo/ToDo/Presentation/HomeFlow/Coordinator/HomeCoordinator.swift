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
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var homeViewController: HomeViewController
    
    // MARK: - Initializer
    init(_ navigationController: UINavigationController) {
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
        print("Home Did Finish")
    }
}
