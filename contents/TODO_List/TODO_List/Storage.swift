import Foundation

final class Storage {
  
  static let shared = Storage()
  private init() {}
  private let key: String = "todoList"
  
  func create(_ todo: Todo) {
    var todos = read()
    todos.append(todo)
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
    // 반복문에서는 Todo 객체가 let으로 나옴...
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
    var todos = read()
    var newTodos = todos.filter { $0.id != todo.id }
    save(newTodos)
  }
}
