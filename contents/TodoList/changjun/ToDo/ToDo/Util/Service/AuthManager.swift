//
//  AuthManager.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

final class AuthManager {
    
    // MARK: - Singleton
    static let shared = AuthManager()
    
    // MARK: - Initializer
    private init() {
        
    }
    
    // MARK: - Properties
    var isTokenSaved: Bool {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKey.authToken) != nil
        }
    }
    
    var isLoginned: Bool {
        get {
            // try token
            false
        }
    }
    
    // MARK: - Functions
    func validateAuth() -> Bool {
        if self.isTokenSaved { // 토큰이 저장되어 있어 자동 로그인 시도 가능
            print("Trying auto-login.")
            return true
        } else { // 저장되어 있어 자동 로그인 불가능
            print("Cannot find token. User should log-in themselves.")
            return false
        }
    }
}
