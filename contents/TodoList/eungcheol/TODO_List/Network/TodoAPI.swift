//
//  TodoAPI.swift
//  TODO_List
//
//  Created by 김응철 on 2022/11/27.
//

import Foundation

import Moya

enum TodoAPI {
  case retrieve
  case retrieveId(todoID: Int)
  case update(todoID: Int, body: TodoRequestDTO)
  case delete(todoID: Int)
  case create(memberID: Int, body: TodoRequestDTO)
}

extension TodoAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://jw-todo.inuappcenter.kr")!
  }
  
  var path: String {
    switch self {
    case .create(let memberId, _ ):
      return "/todos/memberId/\(memberId)"
    case let .delete(todoID), let .update(todoID, _), let .retrieveId(todoID):
      return "/todos/\(todoID)"
    default:
      return "/todos"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .retrieve, .retrieveId: return .get
    case .delete: return .delete
    case .update: return .put
    case .create: return .post
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Moya.Task {
    switch self {
    case let .create(_, body), let .update(_, body):
      return .requestJSONEncodable(body)
      
    default: return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
}
