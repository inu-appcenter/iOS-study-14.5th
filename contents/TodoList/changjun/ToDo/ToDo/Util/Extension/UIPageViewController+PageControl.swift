//
//  UIPageViewController+PageControl.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

extension UIPageViewController {
    func goToNextPage() {
        guard let currentVC = self.viewControllers?.first else { return }
        guard let nextVC = dataSource?.pageViewController(self, viewControllerAfter: currentVC) else { return }
        setViewControllers([nextVC], direction: .forward, animated: true)
    }
    
    func goToPreviousPage() {
        guard let currentVC = self.viewControllers?.first else { return }
        guard let previousVC = dataSource?.pageViewController(self, viewControllerBefore: currentVC) else { return }
        setViewControllers([previousVC], direction: .forward, animated: true)
    }
}
