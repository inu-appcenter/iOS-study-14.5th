//
//  HomeViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import Foundation

final class HomeViewModel: ViewModel {
    
    // MARK: - Properties
    weak var coordinator: HomeCoordinator?
    let homeUseCase: HomeUseCase
    
    // MARK: - Observables
    let todoProgress: Observable<Int> = Observable(0)
    
    // MARK: - Initializer
    init(coordinator: HomeCoordinator, homeUseCase: HomeUseCase) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
        self.syncViewModel()
    }
    
    // MARK: - Functions
    func addButtonDidTap() {
        self.coordinator?.showCreateFlow()
    }
    
    func syncViewModel() {
        self.todoProgress.value = ToDoManager.shared.calculateProgressPercentage()
    }
    
    func validateAuth() {
        switch AuthManager.shared.validateAuth() {
        case true: // 유저 데이터 발견
            let validToken =  AuthManager.shared.validateToken() // 토큰 체크
            print("Valid Token: \(validToken)")
            UserDefaults.standard.set(validToken, forKey: UserDefaultsKey.authToken) // 갱신되거나 기존 토큰 설정
            print(UserDefaults.standard.string(forKey: UserDefaultsKey.authToken) ?? "No token found")
        case false: // 유저 데이터 발견 실패
            self.coordinator?.showOnboardFlow()
        }
    }
    
    func syncWithServer() {
        ToDoManager.shared.syncWithServer()
    }
}

// MARK: - Privates
private extension HomeViewModel {
    
    func handleStateWithDate(of todo: ToDo) -> State {
        if let due = todo.dueDate {
            if due.onlyDate < Date.now.onlyDate {
                return .expired
            } else {
                return .inProgress
            }
        }
        return .completed
    }
}
