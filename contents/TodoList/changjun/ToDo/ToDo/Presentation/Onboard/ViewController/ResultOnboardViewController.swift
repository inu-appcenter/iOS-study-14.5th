//
//  ResultOnboardViewController.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/27.
//

import UIKit

import Hero
import Lottie
import SnapKit

final class ResultOnboardViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: OnboardViewModel?
    
    // MARK: - UI Components
    let loadingIndicator: AnimationView = {
        let loading = AnimationView.init(name: LottieFile.loading)
        loading.loopMode = .loop
        return loading
    }()
    
    let doneIndicator: AnimationView = {
        let loading = AnimationView.init(name: LottieFile.okay)
        loading.loopMode = .loop
        return loading
    }()
    
    let errorIndicator: AnimationView = {
        let loading = AnimationView.init(name: LottieFile.error)
        loading.loopMode = .loop
        return loading
    }()
    
    lazy var confirmButton: ConfirmButton = {
        let button = ConfirmButton()
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
        self.viewModel?.createSignUpData()
    }
}

// MARK: - UI Configuration
private extension ResultOnboardViewController {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [confirmButton, loadingIndicator, doneIndicator, errorIndicator].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(64)
        }
        self.doneIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(88)
        }
        self.errorIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(88)
        }
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(52)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
        [loadingIndicator, doneIndicator, errorIndicator].forEach {
            $0.isHidden = true
        }
    }
}

// MARK: - Private Functions
private extension ResultOnboardViewController {
    @objc
    func buttonDidTap(_ sender: UIButton) {
        self.viewModel?.confirmButtonDidTap()
    }
    
    func bindViewModel() {
        self.viewModel?.type.subscribe {
            self.confirmButton.setTitle($0.confirmButtonTitle, for: .normal)
        }
        self.viewModel?.isAuthSuccess.subscribe { isAuthSuccess in
            switch isAuthSuccess {
            case .success:
                self.loadingIndicator.isHidden = true
                self.doneIndicator.isHidden = false
                self.doneIndicator.loopMode = .playOnce
                self.doneIndicator.play()
            case .failure:
                self.loadingIndicator.isHidden = true
                self.errorIndicator.isHidden = false
                self.errorIndicator.loopMode = .playOnce
                self.errorIndicator.play()
            case .notyet:
                self.loadingIndicator.isHidden = false
                self.loadingIndicator.loopMode = .loop
                self.loadingIndicator.play()
            }
        }
    }
}
