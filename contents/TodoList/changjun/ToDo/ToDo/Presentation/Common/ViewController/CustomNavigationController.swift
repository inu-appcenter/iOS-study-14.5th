//
//  CustomNavigationController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/24.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
