//
//  ApplicationCoordinator.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    
    // MARK: - Properties
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: CustomNavigationController
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Initializer
    init(_ navigationController: CustomNavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    func start() {
        self.showHomeFlow()
    }
    
    func showHomeFlow() {
        let homeCoordinator = HomeCoordinator.init(self.navigationController)
        homeCoordinator.finishDelegate = self
        self.childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}

// MARK: - Finish Delegate
extension ApplicationCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.navigationController.viewControllers.removeAll()
    }
}
