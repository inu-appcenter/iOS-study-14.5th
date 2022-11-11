//
//  DateSelectorCollectionView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

class DateSelectorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
private extension DateSelectorView {
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
        
    }
}
