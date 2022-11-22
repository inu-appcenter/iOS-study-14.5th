//
//  ToDoManager.swift
//  todoey
//
//  Created by 이창준 on 2022/11/12.
//

import Foundation

enum ToDoManagerError: Error {
    case emptyList, decodeError, notFound
}

final class ToDoManager {
    // MARK: - Singleton
    static let shared = ToDoManager()
    
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    
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
            self.syncToUserDefaults()
        }
    }
    
    // MARK: - CRUD
    // Function to save temporary todo data to UserDefaults
    func syncToUserDefaults() {
        if let encodedToDo = try? JSONEncoder().encode(self.todos) {
            userDefaults.set(encodedToDo, forKey: UserDefaultsKey.todo)
        }
    }
    
    // Function to create new todo data
    func create(_ todo: ToDo) {
        self.todos.append(todo)
    }
    
    // Function to get all datas from todo data
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
    
    // Function to replace old todo data with new one
    func update(_ newToDo: ToDo) {
        self.todos.enumerated().forEach { (idx, todo) in
            if todo.id == newToDo.id {
                self.todos[idx] = newToDo
            }
        }
    }
    
    // Function to remove todo data from temporary todo data
    func delete(_ todo: ToDo) {
        self.todos.enumerated().forEach {
            if $1.id == todo.id {
                todos.remove(at: $0)
            }
        }
    }
}

extension ToDoManager {
    // Function to get todo data from UserDefaults
    func getToDos() throws -> [ToDo] {
        guard let data = userDefaults.data(forKey: UserDefaultsKey.todo) else {
            throw ToDoManagerError.emptyList
        }
        guard let decodedToDo = try? JSONDecoder().decode([ToDo].self, from: data) else {
            throw ToDoManagerError.decodeError
        }
        return decodedToDo
    }
}
