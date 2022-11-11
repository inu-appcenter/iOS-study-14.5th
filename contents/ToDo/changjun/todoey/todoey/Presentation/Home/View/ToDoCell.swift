//
//  ToDoCell.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

class ToDoCell: UICollectionViewCell {
    
    static let identifier = "ToDoCell"
    
    // MARK: - UI Components
    lazy var todoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.textColor = .white
        $0.text = "초롬이 간식 사기"
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
private extension ToDoCell {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [todoLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.todoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(50)
        }
    }
    
    func configureStyles() {
        
    }
}

