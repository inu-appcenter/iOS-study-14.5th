//
//  ParentViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/26.
//

import Foundation

protocol ChildViewModel: AnyObject {
    var parentViewModel: ViewModel? { get set }
}
