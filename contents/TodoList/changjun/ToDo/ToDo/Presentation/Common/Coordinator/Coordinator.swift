//
//  Coordinator.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import UIKit

protocol Coordinator: AnyObject {
    
    // MARK: - Properties
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: CustomNavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    // MARK: - Initializer
    init(_ navigationController: CustomNavigationController)
    
    // MARK: - Functions
    func start()
    func finish()
}

// MARK: - Default Function
extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// MARK: - Finish Delegate
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
