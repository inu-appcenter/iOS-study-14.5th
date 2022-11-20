import Foundation

final class Storage {
  
  static let shared = Storage()
  private init() {}
  private let key: String = "todoList"
  
  func create(_ todo: Todo) {
    var todos = read()
    todos.insert(todo, at: 0)
    guard let data = try? PropertyListEncoder().encode(todos) else {
      fatalError("Encording Error!")
    }
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey: key)
    userDefaults.synchronize()
  }
  
  func save(_ todos: [Todo]) {
    guard let data = try? PropertyListEncoder().encode(todos) else {
      fatalError("Encording Error!")
    }
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey: key)
    userDefaults.synchronize()
  }
  
  func read() -> [Todo] {
    let userDefaults = UserDefaults.standard
    guard let data = userDefaults.data(forKey: key) else {
      return []
    }
    guard let todos = try? PropertyListDecoder().decode([Todo].self, from: data) else {
      fatalError("Decoding Error!")
    }
    return todos
  }
  
  func update(_ todo: Todo) {
    var newTodos = read()
    for (n, x) in newTodos.enumerated() {
      if x.id == todo.id {
        var newTodo = newTodos[n]
        newTodo.title = todo.title
        newTodo.state = todo.state
        newTodos[n] = newTodo
      }
    }
    save(newTodos)
  }
  
  func delete(_ todo: Todo) {
    let todos = read()
    let newTodos = todos.filter { $0.id != todo.id }
    save(newTodos)
  }
}

extension Storage {
  var todos: [Todo] {
    return read()
  }
}
