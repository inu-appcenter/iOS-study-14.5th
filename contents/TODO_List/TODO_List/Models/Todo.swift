import Foundation

struct Todo: Codable {
  let title: String
  let date: Date
  let state: State
}
