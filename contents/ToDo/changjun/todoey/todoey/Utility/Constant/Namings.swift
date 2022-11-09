//
//  Namings.swift
//  todoey
//
//  Created by 이창준 on 2022/11/08.
//

import UIKit

struct SF {
    enum Navigation {
        case preference
        case add
        
        var iconImage: UIImage? {
            switch self {
            case .preference:
                return UIImage(systemName: "gearshape.fill")
            case .add:
                return UIImage(systemName: "plus")
            }
        }
    }
}
