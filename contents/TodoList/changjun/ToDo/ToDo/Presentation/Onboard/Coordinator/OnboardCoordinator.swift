//
//  LoginCoordinator.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

import Hero

final class OnboardCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: CustomNavigationController
    var childCoordinators: [Coordinator] = []
    var onboardPageViewController: FirstOnboardViewController
    
    init(_ navigationController: CustomNavigationController) {
        self.navigationController = navigationController
        self.onboardPageViewController = FirstOnboardViewController()
    }
    
    func start() {
        self.onboardPageViewController = FirstOnboardViewController()
        self.onboardPageViewController.viewModel = OnboardViewModel(
            coordinator: self
        )
        self.onboardPageViewController.modalPresentationStyle = .overCurrentContext
        self.navigationController.pushViewController(self.onboardPageViewController, animated: false)
    }
    
    func pushIDFlow(_ viewModel: OnboardViewModel) {
        let idVC = IDOnboardViewController()
        idVC.viewModel = viewModel
        idVC.hero.isEnabled = true
        self.navigationController.pushViewController(idVC, animated: true)
    }
    
    func pushPasswordFlow(_ viewModel: OnboardViewModel) {
        let pwVC = PWOnboardViewController()
        pwVC.hero.isEnabled = true
        pwVC.modalTransitionStyle = .partialCurl
        pwVC.hero.modalAnimationType = .selectBy(
            presenting: .slide(direction: .up),
            dismissing: .slide(direction: .down)
        )
        pwVC.viewModel = viewModel
        self.navigationController.pushViewController(pwVC, animated: true)
    }
    
    func pushNameFlow(_ viewModel: OnboardViewModel) {
        let nameVC = NameOnboardViewController()
        nameVC.hero.isEnabled = true
        nameVC.viewModel = viewModel
        self.navigationController.pushViewController(nameVC, animated: true)
    }
    
    func pushAgeFlow(_ viewModel: OnboardViewModel) {
        let ageVC = AgeOnboardViewController()
        ageVC.hero.isEnabled = true
        ageVC.viewModel = viewModel
        self.navigationController.pushViewController(ageVC, animated: true)
    }
    
    func pushConfirmFlow(_ viewModel: OnboardViewModel) {
        let confirmVC = ConfirmOnboardViewController()
        confirmVC.hero.isEnabled = true
        confirmVC.viewModel = viewModel
        self.navigationController.pushViewController(confirmVC, animated: true)
    }
    
    func pushResultFlow(_ viewModel: OnboardViewModel) {
        let resultVC = ResultOnboardViewController()
        resultVC.hero.isEnabled = true
        resultVC.viewModel = viewModel
        self.navigationController.pushViewController(resultVC, animated: true)
    }
    
    func popToRoot() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
