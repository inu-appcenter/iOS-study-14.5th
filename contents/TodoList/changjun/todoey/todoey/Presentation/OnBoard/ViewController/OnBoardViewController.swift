//
//  OnBoardViewController.swift
//  todoey
//
//  Created by 이창준 on 2022/11/19.
//

import UIKit

import Then
import SnapKit

class OnBoardViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    lazy var tempLabel = UILabel().then {
        $0.text = "Test page for HTTP networking."
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - UI Configuration
private extension OnBoardViewController {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        self.view.addSubview(self.tempLabel)
    }
    
    func configureConstraints() {
        self.tempLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
    }
}

