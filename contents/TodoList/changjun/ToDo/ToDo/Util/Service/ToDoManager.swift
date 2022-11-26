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

enum ToDoMethod {
    case create, read, get, update, toggle, delete
}

final class ToDoManager {
    // MARK: - Singleton
    /// 로컬 ToDo 데이터를 처리할 Singleton 객체
    static let shared = ToDoManager()
    
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Initializer
    private init() {
        do {
            self.todos = try self.getToDos()
        } catch {
            switch error {
            case ToDoManagerError.emptyList:
                print("""
                Failed fetching ToDo from UserDefaults.
                Possibly it's empty.
                """)
            case ToDoManagerError.decodeError:
                print("Decoding error: \(error)")
            default:
                print(error)
            }
        }
    }
    
    // MARK: - Data
    /// Singleton 객체에 저장되는 ToDo 데이터입니다.
    /// `didSet`을 사용해 값이 변할 때마다 UserDefaults와 sync됩니다.
    var todos: [ToDo] = [] {
        didSet {
            self.syncToUserDefaults()
        }
    }
    
    // MARK: - CRUD
    /// Singleton 객체에 저장된 ToDo 데이터들을 UserDefaults에 저장합니다.
    func syncToUserDefaults() {
        if let encodedToDo = try? JSONEncoder().encode(self.todos) {
            userDefaults.set(encodedToDo, forKey: UserDefaultsKey.todo)
        }
    }
    
    /// Singleton 객체에 새로운 ToDo 데이터를 create 합니다.
    func create(_ todo: ToDo) {
        self.todos.append(todo)
    }
    
    /// UserDefaults에 저장되어 있는 모든 ToDo 데이터들을 불러옵니다.
    /// 불러온 데이터는 Singleton 객체에 저장됩니다.
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
    
    /// Singleton 객체에 저장된 ToDo 데이터를 다른 데이터로 Update 합니다.
    func update(_ newToDo: ToDo) {
        self.todos.enumerated().forEach { (idx, todo) in
            if todo.id == newToDo.id {
                self.todos.replace(at: idx, with: newToDo)
            }
        }
    }
    
    /// Singleton 객체에 저장된 ToDo 데이터를 Delete 합니다.
    func delete(_ deletingTodo: ToDo) {
        self.todos.enumerated().forEach { (idx, todo) in
            if deletingTodo.id == todo.id {
                todos.remove(at: idx)
            }
        }
    }
    
    /// Singleton에 저장된 ToDo 데이터 중 선택한 날짜에 해당되는 데이터만 받아옵니다.
    func fetchToDo(within date: Date) {
//        let filteredDate = self.todos.lazy.filter { todo -> Bool in
//            guard let dueDate = todo.dueDate else { return false }
//            let isDueDate = dueDate <= date
//            return isDueDate
//        }
    }
}

private extension ToDoManager {
    // Function to get todo data from UserDefaults
    /// UserDefaults에 저장되어 있는 모든 ToDo 데이터를 불러옵니다.
    /// 불러온 데이터는 Singleton 객체에 저장됩니다.
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
