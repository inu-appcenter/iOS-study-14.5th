//
//  SetupViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import UIKit

import Hero
import KDCircularProgress
import SnapKit

final class FirstOnboardViewController: OnboardViewController {
    
    // MARK: - Properties
    var viewModel: OnboardViewModel?
    
    // MARK: - UI Components
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "TooDoo!"
        label.font = .systemFont(ofSize: 60, weight: .semibold)
        label.textColor = .tdPink
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "yes, it's todo"
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateDemos()
    }
    
    // MARK: - UI Configuration
    override func configureUI() {
        super.configureUI()
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    override func configureLayout() {
        super.configureLayout()
        [progressCircle, mainLabel, subLabel].forEach {
            self.view.addSubview($0)
        }
        self.progressCircle.addSubview(self.progressLabel)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        self.progressCircle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.progressLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-150)
        }
        self.subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.mainLabel.snp.top)
        }
        self.confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).inset(-24)
        }
    }
    
    override func configureStyles() {
        super.configureStyles()
        self.idTextField.isHidden = true
    }
    
    // MARK: - Functions
    override func confirmButtonTap(_ sender: UIButton) {
        super.confirmButtonTap(sender)
        self.viewModel?.confirmButtonDidTap()
    }
}

// MARK: - Private Functions
private extension FirstOnboardViewController {
    func bindViewModel() {
        self.viewModel?.type.subscribe {
            self.confirmButton.setTitle($0.confirmButtonTitle, for: .normal)
        }
    }
    
    func animateDemos() {
        self.demo(deadline: .now() + 0.7, value: 80)
    }
    
    func demo(deadline: DispatchTime, value: Int) {
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.progressLabel.attributedText = value.configureAttributedPercentage()
            self.progressCircle.animate(
                toAngle: Double(value) / 100 * 360,
                duration: 0.7
            ) { _ in
                self.demo(deadline: .now() + 0.7, value: 25)
            }
        }
    }
}
