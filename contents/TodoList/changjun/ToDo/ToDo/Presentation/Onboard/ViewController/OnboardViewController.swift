//
//  BaseOnboardViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

import Hero
import KDCircularProgress
import SnapKit
import SkyFloatingLabelTextField

class OnboardViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    lazy var progressCircle: KDCircularProgress = {
        let progress = KDCircularProgress()
        progress.startAngle = -90
        progress.trackThickness = 0.25
        progress.progressThickness = 0.3
        progress.glowMode = .forward
        progress.clockwise = true
        progress.trackColor = .tdBackgroundGray
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
        label.attributedText = 0.configureAttributedPercentage()
        return label
    }()
    
    lazy var idTextField: InfoTextField = {
        let textField = InfoTextField()
        textField.title = "아이디"
        textField.placeholder = "아이디를 입력해주세요."
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(idTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var pwTextField: InfoTextField = {
        let textField = InfoTextField()
        textField.title = "비밀번호"
        textField.placeholder = "비밀번호를 입력해주세요."
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var nameTextField: InfoTextField = {
        let textField = InfoTextField()
        textField.title = "이름"
        textField.placeholder = "이름을 입력해주세요."
        textField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var ageTextField: InfoTextField = {
        let textField = InfoTextField()
        textField.title = "나이"
        textField.placeholder = "나이를 입력해주세요."
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(ageTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var confirmButton: ConfirmButton = {
        let button = ConfirmButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(confirmButtonTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        self.configureNavigationBar()
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func configureLayout() {
        [confirmButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
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
    
    // MARK: - Functions
    @objc
    func confirmButtonTap(_ sender: UIButton) {
        HapticManager.shared.impactFeedback(.rigid)
    }
    
    @objc
    func idTextFieldDidChange(_ sender: UITextField) {
        
    }
    
    @objc
    func passwordTextFieldDidChange(_ sender: UITextField) {
        
    }
    
    @objc
    func nameTextFieldDidChange(_ sender: UITextField) {
        
    }
    
    @objc
    func ageTextFieldDidChange(_ sender: UITextField) {
        
    }
}
