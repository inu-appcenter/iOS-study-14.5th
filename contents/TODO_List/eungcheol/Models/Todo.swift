import Foundation

struct Todo: Codable, Identifiable {
  var id = UUID()
  var title: String
  var state: State
}
