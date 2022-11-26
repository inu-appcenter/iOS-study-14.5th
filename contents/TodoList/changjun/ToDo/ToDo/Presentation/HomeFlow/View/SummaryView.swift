//
//  SummaryView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/09.
//

import UIKit

import KDCircularProgress
import SnapKit

class SummaryView: UIView {
    
    // MARK: - Properties
    var viewModel: SummaryViewModel?
    
    // MARK: - UI Components
    lazy var progressCircle: KDCircularProgress = {
        let progress = KDCircularProgress()
        progress.startAngle = -90
        progress.trackThickness = 0
        progress.progressThickness = 0.3
        progress.glowMode = .forward
        progress.clockwise = true
        progress.gradientRotateSpeed = 1
        progress.roundedCorners = true
        progress.set(colors: .tdBlue, .tdPink, .tdPurple)
        progress.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        return progress
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    lazy var staticLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        let staticTextToday: UILabel = {
            let label = UILabel()
            label.text = "이만큼이나"
            return label
        }()
        let staticTextDone: UILabel = {
            let label = UILabel()
            label.text = "완료했어요!"
            return label
        }()
        [staticTextToday, staticTextDone].forEach {
            stackView.addArrangedSubview($0)
            $0.font = .systemFont(ofSize: 13, weight: .semibold)
        }
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func bindViewModel() {
        lazy var homeViewModel = self.viewModel?.parentViewModel as? HomeViewModel
        homeViewModel?.todoProgress.subscribe {
            guard let percentage = self.viewModel?.convertToPercentage($0) else { return }
            self.progressCircle.animate(toAngle: percentage, duration: 0.7, completion: nil)
            self.progressLabel.attributedText = self.configureAttributedPercentage($0)
        }
    }
}

// MARK: - UI Configuration
private extension SummaryView {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        self.addSubview(self.progressCircle)
        self.progressCircle.addSubview(self.progressLabel)
        self.addSubview(self.staticLabelsStackView)
    }
    
    func configureConstraints() {
        self.progressCircle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        self.progressLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.staticLabelsStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.progressCircle.snp.trailing).offset(24)
            make.centerY.equalTo(self.progressCircle)
        }
    }
    
    func configureStyles() {
        
    }
    
    func configureAttributedPercentage(_ value: Int) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        let regularAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21)]
        let smallAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        attributedString.append(
            NSMutableAttributedString(string: "\(value)", attributes: regularAttrs))
        attributedString.append(
            NSMutableAttributedString(string: "%", attributes: smallAttrs))
        return attributedString
    }
}
