//
//  SummaryView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/09.
//

import UIKit

import KDCircularProgress

class SummaryView: UIView {
    
    private var viewModel = HomeViewModel()
    
    // MARK: - UI Components
    lazy var progressCircle = KDCircularProgress().then {
        $0.startAngle = -90
        $0.trackThickness = 0
        $0.progressThickness = 0.3
        $0.glowMode = .forward
        $0.clockwise = true
        $0.gradientRotateSpeed = 1
        $0.roundedCorners = true
        $0.set(colors: .systemBlue, .systemIndigo, UIColor.systemTeal, .magenta, UIColor.systemOrange)
        $0.angle = 90
    }
    
    lazy var progressLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.text = self.viewModel.progressPercentage
    }
    
    lazy var staticLabelsStackView = UIStackView().then { stackView in
        let staticTextToday = UILabel().then {
            $0.text = self.viewModel.staticText.0
        }
        let staticTextDone = UILabel().then {
            $0.text = self.viewModel.staticText.1
        }
        [staticTextToday, staticTextDone].forEach {
            stackView.addArrangedSubview($0)
            $0.font = .systemFont(ofSize: 13, weight: .semibold)
        }
        stackView.axis = .vertical
        stackView.alignment = .leading
    }
    
    lazy var toggleSwitch = UISwitch().then {
        $0.onTintColor = .systemIndigo
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Binding
private extension SummaryView {
    func bindViewModel() {
//        let input = viewModel.
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
        self.addSubview(self.toggleSwitch)
    }
    
    func configureConstraints() {
        self.progressCircle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(80)
        }
        self.progressLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.staticLabelsStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.progressCircle.snp.trailing).offset(12)
            make.centerY.equalTo(self.progressCircle)
        }
        self.toggleSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func configureStyles() {
        
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct SummaryPreView: PreviewProvider {
    static var previews: some View {
        SummaryView().toPreview()
    }
}
#endif
