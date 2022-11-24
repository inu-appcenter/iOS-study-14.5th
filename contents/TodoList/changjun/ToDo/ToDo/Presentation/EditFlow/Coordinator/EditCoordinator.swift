//
//  EditCoordinator.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import UIKit

final class EditCoordinator: Coordinator {
    
    // MARK: - Properties
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: CustomNavigationController
    var childCoordinators: [Coordinator] = []
    var editViewController: EditViewController
    
    // MARK: - Initializer
    init(_ navigationController: CustomNavigationController) {
        self.navigationController = navigationController
        self.editViewController = EditViewController()
    }
    
    // MARK: - Functions
    func start() {
        
    }
    
    func pushCreateViewController(with type: EditViewControllerType) {
        self.editViewController.viewModel = EditViewModel(
            coordinator: self,
            editUseCase: EditUseCase(),
            editViewControllerType: type
        )
        self.navigationController.pushViewController(self.editViewController, animated: true)
    }
    
    func pushEditViewController(with type: EditViewControllerType, data: ToDo) {
        self.editViewController.viewModel = EditViewModel(
            coordinator: self,
            editUseCase: EditUseCase(),
            editViewControllerType: type,
            todoDataToEdit: data
        )
        self.navigationController.pushViewController(self.editViewController, animated: true)
    }
}

extension EditCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        print("Edit Did Finish")
    }
}
