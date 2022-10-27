enum MenuSymbol: CaseIterable {
  case repositories
  case starred
  case organizations
  
  var imageName: String {
    switch self {
    case .repositories: return "book.closed"
    case .starred: return "star"
    case .organizations: return "building.2"
    }
  }
  
  var description: String {
    switch self {
    case .repositories: return "Repositories"
    case .starred: return "Starred"
    case .organizations: return "Organizations"
    }
  }
  
  var number: String {
    switch self {
    case .repositories: return "27"
    case .starred: return "3"
    case .organizations: return "3"
    }
  }
}
