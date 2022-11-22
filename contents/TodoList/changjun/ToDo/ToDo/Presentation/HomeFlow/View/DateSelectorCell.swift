//
//  DateSelectorCollectionViewCell.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

import SnapKit

class DateSelectorCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "DateSelectorCell"
    
    // MARK: - UI Configuration
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "00"
        return label
    }()
    
    lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Mon"
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    func updateDayLabel(with date: Date) {
        self.dayLabel.text = date.convertTo(format: "dd")
        self.dayOfWeekLabel.text = date.convertTo(format: "E")
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
            make.centerY.equalToSuperview().offset(-8)
        }
        self.dayOfWeekLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.dayLabel.snp.bottom)
        }
    }
    
    func configureStyles() {
        self.layer.cornerRadius = 30
        self.backgroundColor = .tdLightGray
    }
}
