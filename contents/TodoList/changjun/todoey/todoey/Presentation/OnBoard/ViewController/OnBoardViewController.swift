//
//  OnBoardViewController.swift
//  todoey
//
//  Created by 이창준 on 2022/11/19.
//

import UIKit

import Then
import SnapKit

import Alamofire

class OnBoardViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    lazy var tempLabel = UILabel().then {
        $0.text = "Test page for HTTP networking."
    }
    
    lazy var testButton = UIButton().then {
        $0.addTarget(self, action: #selector(launch), for: .touchUpInside)
        $0.backgroundColor = BrandColor.brandPink.value
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setTitle("Launch 🚀", for: .normal)
    }
    
    lazy var testView = UITextView().then {
        $0.font = .systemFont(ofSize: 18)
        $0.isHidden = true
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    @objc func launch() {
        self.testView.isHidden = false
        let members = "members"
        AF.request(N.baseURL + members, method: .get)
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200...200)
            .responseDecodable(of: [Member].self) { response in
                switch response.result {
                case .success(let value):
                    var text = ""
                    DispatchQueue.main.async {
                        value.forEach { member in
                            text.append("이름: \(member.name) \n이메일: \(member.email)\n나이: \(member.age)\n\n")
                        }
                        self.testView.text = text
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: - UI Configuration
private extension OnBoardViewController {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [tempLabel, testButton, testView].forEach {
            self.view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        self.tempLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.testButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(48)
            make.width.equalTo(150)
            make.height.equalTo(48)
        }
        self.testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
    }
    
    func configureStyles() {
        self.view.backgroundColor = .systemBackground
        self.testButton.layer.cornerRadius = 24
    }
}

