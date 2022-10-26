enum Symbols {
  case gear
  case share
  
  var imageName: String {
    switch self {
    case .gear: return "gearshape"
    case .share: return "square.and.arrow.up"
    }
  }
}
