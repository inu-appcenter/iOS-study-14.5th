enum DescriptionSymbol: CaseIterable {
  case building
  case location
  case link
  case email
  case person
  
  var imageName: String {
    switch self {
    case .building: return "building.2"
    case .location: return "mappin.and.ellipse"
    case .link: return "link"
    case .email: return "envelope"
    case .person: return "person"
    }
  }
  
  var description: String {
    switch self {
    case .building: return "Incheon National University"
    case .location: return "Incheon, South Korea"
    case .link: return "eung7.tistory.com"
    case .email: return "e.cheol8567@gmail.com"
    case .person: return "15 followers ･ 14 following"
    }
  }
}
