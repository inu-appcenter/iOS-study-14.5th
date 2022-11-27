//
//  LoginViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

import Alamofire

final class OnboardViewModel: ViewModel {
    
    // MARK: - Properties
    weak var coordinator: OnboardCoordinator?
    
    // MARK: - Initializer
    init(coordinator: OnboardCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Observables
    let type: Observable<OnboardType> = Observable(.start)
    let idString: Observable<String?> = Observable("")
    let pwString: Observable<String?> = Observable("")
    let nameString: Observable<String?> = Observable("")
    let ageString: Observable<Int?> = Observable(0)
    let isAuthSuccess: Observable<AuthResult> = Observable(.notyet)
    
    // MARK: - Functions
    func confirmButtonDidTap() {
        switch self.type.value {
        case .start:
            self.type.value = .id
            self.coordinator?.pushIDFlow(self)
        case .id:
            self.type.value = .pw
            self.coordinator?.pushPasswordFlow(self)
        case .pw:
            self.type.value = .name
            self.coordinator?.pushNameFlow(self)
        case .name:
            self.type.value = .age
            self.coordinator?.pushAgeFlow(self)
        case .age:
            self.type.value = .confirm
            self.coordinator?.pushConfirmFlow(self)
        case .confirm:
            self.type.value = .result
            self.coordinator?.pushResultFlow(self)
        case .result:
            self.coordinator?.popToRoot()
        }
    }
    
    func createSignUpData() {
        if let id = self.idString.value,
           let password = self.pwString.value,
           let name = self.nameString.value,
           let age = self.ageString.value {
            let signUpData = SignUp(
                id: id,
                password: password,
                name: name,
                age: age
            )
            AuthManager.shared.requestSignUp(with: signUpData) { result in
                self.validateSignIn()
            }
        }
    }
    
    func validateSignIn() {
        if let id = self.idString.value,
           let password = self.pwString.value {
            let signInData = Auth(
                id: id,
                password: password
            )
            AuthManager.shared.requestSignIn(with: signInData) { result, value in
                switch result {
                case .success(_):
                    self.isAuthSuccess.value = .success
                    UserDefaults.standard.set(value?.token, forKey: UserDefaultsKey.authToken)
                case .failure(_):
                    self.isAuthSuccess.value = .failure
                }
            }
        }
    }
}

private extension OnboardViewModel {
    
}
