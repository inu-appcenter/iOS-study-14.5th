//
//  EditViewController.swift
//  todoey
//
//  Created by 이창준 on 2022/11/13.
//

import UIKit

import Then
import SnapKit

class EditViewController: UIViewController {
    
    // MARK: - UI Components

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
    }

}

// MARK: - UI Configuration
private extension EditViewController {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureStyles() {
        self.view.backgroundColor = .magenta
    }
}

