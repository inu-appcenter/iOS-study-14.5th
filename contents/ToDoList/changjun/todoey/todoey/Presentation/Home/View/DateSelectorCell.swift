//
//  DateSelectorCollectionViewCell.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

import SnapKit
import Then

class DateSelectorCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "DateSelectorCell"
    private var viewModel = HomeViewModel.shared
    
    // MARK: - UI Configuration
    lazy var dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.text = "00"
    }
    
    lazy var dayOfWeekLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.text = "Mon"
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    func bind(_ date: Date) {
        self.dayLabel.text = self.viewModel.convertDate(date, to: "dd")
        self.dayOfWeekLabel.text = self.viewModel.convertDate(date, to: "E")
    }
}

// MARK: - UI Configuration
private extension DateSelectorCell {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [dayLabel, dayOfWeekLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.dayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(24)
        }
        self.dayOfWeekLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.dayLabel.snp.bottom)
        }
    }
    
    func configureStyles() {
        self.layer.cornerRadius = 30
        self.backgroundColor = Color.lightGray
    }
}

