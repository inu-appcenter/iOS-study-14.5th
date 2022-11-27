//
//  ProfileViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/27.
//

import Foundation

final class ProfileViewModel {
    
    // MARK: - Properties
    
    // MARK: - Initializer
    init() {
        self.reloadData()
    }
    
    // MARK: - Observables
    let currentTime: Observable<Date> = Observable(.now)
    let profileName: Observable<String> = Observable("")
    
    // MARK: - Functions
    func reloadData() {
        self.currentTime.value = .now
        if let userName = UserDefaults.standard.string(forKey: UserDefaultsKey.userName) {
            self.profileName.value = userName
        }
    }
}
