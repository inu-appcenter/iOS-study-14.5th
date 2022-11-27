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
  case update(memberID: Int, body: TodoRequestDTO)
  case delete(todoID: Int)
  case create(memberID: Int, body: TodoRequestDTO)
}

extension TodoAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://jw-todo.inuappcenter.kr")!
  }
  
  var path: String {
    switch self {
    case .create: return "/todos/memberId"
    default: return "/todos"
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
    case .retrieve: return .requestPlain
      
    case let .retrieveId(id), let .delete(id):
      return .requestParameters(parameters: ["memberID": id], encoding: URLEncoding.queryString)
      
    case let .create(id, body), let .update(id, body):
      guard let data = try? JSONEncoder().encode(body) else { fatalError() }
      return .requestCompositeData(bodyData: data, urlParameters: ["memberID": id])
    }
  }
  
  var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
}
