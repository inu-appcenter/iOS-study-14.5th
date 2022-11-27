//
//  TodoService.swift
//  TODO_List
//
//  Created by 김응철 on 2022/11/27.
//

import UIKit

import Moya
import Result

struct TodoService {
  
  static let instance = TodoService()
  let provider = MoyaProvider<TodoAPI>()
  private init() {}
}

extension TodoService {
  func getTodos(completion: @escaping ([Todo]) -> Void) {
    provider.request(.retrieve) { result in
      switch result {
      case .success(let response):
        do {
          _ = try response.filterSuccessfulStatusCodes()
          
          guard let todos = try? JSONDecoder().decode([Todo].self, from: response.data) else { fatalError() }
          DispatchQueue.main.async {
            completion(todos)
          }
        } catch {
          print(error.localizedDescription)
          fatalError()
        }
      case .failure(let error):
        print(error.localizedDescription)
        fatalError()
      }
    }
  }
  
  func updateTodo(_ todoID: Int, body: TodoRequestDTO, completion: @escaping () -> Void) {
    provider.request(.update(todoID: todoID, body: body)) { result in
      switch result {
      case .success(let response):
        do {
          _ = try response.filterSuccessfulStatusCodes()
          DispatchQueue.main.async {
            completion()
          }
        } catch {
          print(error.localizedDescription)
          fatalError()
        }
      case .failure(let error):
        print(error.localizedDescription)
        fatalError()
      }
    }
  }
  
  func deleteTodo(_ todoID: Int, completion: @escaping () -> Void) {
    provider.request(.delete(todoID: todoID)) { result in
      switch result {
      case .success(let response):
        do {
          _ = try response.filterSuccessfulStatusCodes()
          DispatchQueue.main.async {
            completion()
          }
        } catch {
          print(error.localizedDescription)
          fatalError()
        }
      case .failure(let error):
        print(error.localizedDescription)
        fatalError()
      }
    }
  }
  
  func createTodo(_ memberID: Int, body: TodoRequestDTO, completion: @escaping () -> Void) {
    provider.request(.create(memberID: memberID, body: body)) { result in
      switch result {
      case .success(let response):
        do {
          _ = try response.filterSuccessfulStatusCodes()
          DispatchQueue.main.async {
            completion()
          }
        } catch {
          print(error.localizedDescription)
          fatalError()
        }
      case .failure(let error):
        print(error.localizedDescription)
        fatalError()
      }
    }
  }
}
