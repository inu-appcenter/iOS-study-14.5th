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
    var isMemberLoggedIn: Bool {
        get {
            UserDefaults.standard.data(forKey: UserDefaultsKey.lastValidAuth) != nil
        }
    }
    
    var isTokenSaved: Bool {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKey.authToken) != nil
        }
    }
    
    // MARK: - Functions
    /// UserDefaults에 Member 정보가 있는지 확인합니다.
    func validateAuth() -> Bool {
        if self.isMemberLoggedIn { // 저장된 유저 데이터가 존재하여 토큰 시도
            print("Found user data. Trying token to request.")
            return true
        } else { // 저장되어 있지 않아 자동 로그인 불가능
            print("Cannot find user data. User should log-in themselves.")
            return false
        }
    }
    
    /// 저장된 토큰이 valid한지 체크합니다. Invalid하다면 새로운 토큰을 발급 받습니다.
    func validateToken() -> String? {
        var validToken: String?
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKey.authResponse) else {
            return nil
        }
        guard let decodedToDo = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
            return nil
        }
        let urlString = BaseURL.baseURL + PathURL.checkToken
        let headers = HTTPHeaders([HTTPHeader(name: Header.authToken, value: decodedToDo.token)])
        AF.request(
            urlString,
            method: .get,
            headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success(_): // Token Valid
                    validToken = decodedToDo.token
                case .failure(_): // Token Invalid
                    validToken = self.refreshToken()
                }
            }
        return validToken
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
    
    /// 토큰 갱신 (UserDefaults의 user에)
    func refreshToken() -> String? {
        var token: String?
        guard let lastValidAuth = UserDefaults.standard.data(forKey: UserDefaultsKey.lastValidAuth) else {
            return nil
        }
        guard let decodedLastValidAuth = try? JSONDecoder().decode(Auth.self, from: lastValidAuth) else {
            return nil
        }
        self.requestSignIn(with: decodedLastValidAuth) { _, value in
            token = value?.token
        }
        UserDefaults.standard.set(decodedLastValidAuth, forKey: UserDefaultsKey.lastValidAuth)
        return token
    }
}
