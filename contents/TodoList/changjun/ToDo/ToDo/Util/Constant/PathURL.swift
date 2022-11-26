//
//  PathURL.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

/// swagger docs 주소
/// https://eg-todo.inuappcenter.kr/swagger-ui.html#/
///

enum PathURL {
    /// BaseURL/{id}
    /// - GET: 회원 단일 조회
    /// - DELETE: 회원 탈퇴
    /// - PATCH: 회원 정보 수정
    static let members = "/members/"
    static let signup = "/members/sign-up" // body required
    static let login = "/members/sign-in" // body required
}
