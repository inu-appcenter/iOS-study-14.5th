//
//  AuthManager.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

import Alamofire

enum AuthResult {
    case success, failure, notyet
}

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
    
    // MARK: - Functions
    func validateAuth() -> Bool {
        if self.isTokenSaved { // 토큰이 저장되어 있어 자동 로그인 시도 가능
            print("Trying auto-login.")
            return true
        } else { // 저장되어 있지 않아 자동 로그인 불가능
            print("Cannot find token. User should log-in themselves.")
            return false
        }
    }
    
    /// Alamofire를 이용하여 요청
    /// TODO: 에러 처리
    func requestSignUp(
        with body: SignUp,
        completion: @escaping ((Result<String, AFError>) -> Void)
    ) {
        let urlString = BaseURL.baseURL + PathURL.signup
        let param = self.createSignUpParam(with: body)
        AF.request(
            urlString,
            method: .post,
            parameters: param,
            encoding: JSONEncoding.prettyPrinted,
            headers: ["Content-Type": "application/json"])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseString { response in
                switch response.result {
                case .success(let successResponse):
                    print("Success Sign-Up: \(successResponse)")
                case .failure(let error):
                    print("Failed Sign-Up: \(error)")
                }
                completion(response.result)
            }
    }
    
    func requestSignIn(
        with auth: Auth,
        completion: @escaping ((Result<AuthResponse, AFError>, AuthResponse?) -> Void)
    ) {
        let urlString = BaseURL.baseURL + PathURL.login
        let param = self.createSignInParam(with: auth)
        AF.request(
            urlString,
            method: .post,
            parameters: param,
            encoding: JSONEncoding.prettyPrinted,
            headers: ["Content-Type": "application/json"])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let successResponse):
                    print("Success Sign-In: \(successResponse)")
                case .failure(let error):
                    print("Failed Sign-In: \(error)")
                }
                completion(response.result, response.value)
            }
    }
}

private extension AuthManager {
    func createSignUpParam(with signup: SignUp) -> Parameters {
        return [
             "age": signup.age,
             "email": signup.email,
             "memberId": signup.id,
             "name": signup.name,
             "password": signup.password,
             "role": "admin"
        ]
    }
    
    func createSignInParam(with auth: Auth) -> Parameters {
        return [
            "memberId": auth.id,
            "password": auth.password
        ]
    }
}
