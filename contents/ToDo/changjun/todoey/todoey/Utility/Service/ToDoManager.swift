//
//  ToDoManager.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import Foundation

enum ToDoManagerError: Error {
    case emptyList, decodeError
}

final class ToDoManager {
    // MARK: - Singleton
    static let shared = ToDoManager()
    private let userDefaults = UserDefaults.standard
    private let key = "todo"
    
    // MARK: - Initializer
    private init() {
        do {
            self.todos = try self.getToDos()
        } catch {
            switch error {
            case ToDoManagerError.decodeError:
                print("Decoding error: \(error)")
            default:
                print(error)
            }
        }
    }
    
    // MARK: - Data
    var todos: [ToDo] = [] {
        didSet {
            self.save()
        }
    }
    
    // MARK: - CRUD
    func save() {
        if let encodedToDo = try? JSONEncoder().encode(self.todos) {
            userDefaults.set(encodedToDo, forKey: self.key)
        }
    }
    
    func create(_ todo: ToDo) {
        self.todos.append(todo)
    }
    
    func read() -> [ToDo]? {
        do {
            let data = try self.getToDos()
            return data
        } catch {
            switch error {
            case ToDoManagerError.decodeError:
                print("Decoding error: \(error)")
            default:
                print(error)
            }
            return nil
        }
    }
    
    func update(_ oldToDo: ToDo) {
        self.todos.enumerated().forEach { (idx, todo) in
            if todo.id == oldToDo.id {
                self.todos[idx] = oldToDo
            }
        }
    }
    
    func delete(_ todo: ToDo) {
        self.todos.enumerated().forEach {
            if $1.id == todo.id {
                todos.remove(at: $0)
            }
        }
    }
}

extension ToDoManager {
    func getToDos() throws -> [ToDo] {
        guard let data = userDefaults.data(forKey: self.key) else {
            throw ToDoManagerError.emptyList
        }
        guard let decodedToDo = try? JSONDecoder().decode([ToDo].self, from: data) else {
            throw ToDoManagerError.decodeError
        }
        return decodedToDo
    }
}
