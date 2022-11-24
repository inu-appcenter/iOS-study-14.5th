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
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.tintColor = .tdLightGray
        button.setImage(SFSymbol.unchecked, for: .normal)
        return button
    }()
    
    lazy var todoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.text = "할 일"
        return label
    }()
    
    lazy var statusView: StatusView = {
        let statusView = StatusView()
        statusView.backgroundColor = .clear
        return statusView
    }()
    
    lazy var dueDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tdLightGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "0000.00.00"
        return label
    }()
    
    lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.addArrangedSubview(self.statusView)
        stackView.addArrangedSubview(self.dueDateLabel)
        return stackView
    }()
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.todoLabel)
        stackView.addArrangedSubview(self.hStackView)
        return stackView
    }()
    
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
        self.dueDateLabel.text = self.todo?.dueDate?.convert(to: "yy.MM.dd")
        self.statusView.setStatus(self.todo?.state)
        if self.todo?.state == .completed {  // Completed
            self.checkButton.setImage(SFSymbol.checked, for: .normal)
            self.checkButton.tintColor = .tdBlue
        } else { // Not Completed
            self.checkButton.setImage(SFSymbol.unchecked, for: .normal)
            self.checkButton.tintColor = .tdLightGray
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
