//
//  ToDoCell.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

import SwipeCellKit

class ToDoCell: SwipeCollectionViewCell {
    
    var todo: ToDo?
    static let identifier = "ToDoCell"
    
    // MARK: - UI Components
    lazy var checkButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.tintColor = Color.lightGray
        $0.setImage(SF.CheckBox.unchecked.iconImage, for: .normal)
    }
    
    lazy var todoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.textColor = .white
        $0.text = "할 일"
    }
    
    lazy var statusView = StatusView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var dueDateLabel = UILabel().then {
        $0.textColor = Color.subGray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.text = "0000.00.00"
    }
    
    lazy var hStackView = UIStackView().then {
        $0.distribution = .fill
        $0.spacing = 4
        $0.alignment = .center
        $0.axis = .horizontal
        $0.addArrangedSubview(self.statusView)
        $0.addArrangedSubview(self.dueDateLabel)
    }
    
    lazy var vStackView = UIStackView().then {
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.axis = .vertical
        $0.addArrangedSubview(self.todoLabel)
        $0.addArrangedSubview(self.hStackView)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func bind(_ todo: ToDo) {
        self.todo = todo
        self.todoLabel.text = self.todo?.title
        self.dueDateLabel.text = self.todo?.dueDate?.toString()
        self.statusView.setStatus(self.todo?.state)
        if self.todo?.state == .completed {  // Completed
            self.checkButton.setImage(SF.CheckBox.checked.iconImage, for: .normal)
            self.checkButton.tintColor = BrandColor.brandBlue.value
        } else { // Not Completed
            self.checkButton.setImage(SF.CheckBox.unchecked.iconImage, for: .normal)
            self.checkButton.tintColor = Color.lightGray
        }
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
        [checkButton, vStackView].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
        self.vStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.checkButton).offset(36)
        }
        self.hStackView.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
    }
    
    func configureStyles() {
        
    }
}

