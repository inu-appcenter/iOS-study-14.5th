//
//  LoginViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

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
}
