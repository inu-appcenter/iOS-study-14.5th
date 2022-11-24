//
//  AddButtonDelegate.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

protocol ToDoDelegate: AnyObject {
    func addButtonDidTap()
    func cellDidLongPressed(with todo: ToDo)
}
