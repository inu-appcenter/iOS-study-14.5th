//
//  TodoSaveRequestDTO.swift
//  TODO_List
//
//  Created by 김응철 on 2022/11/27.
//

import Foundation

struct TodoRequestDTO: Encodable {
  let contents: String
  let isCompleted: Bool
}
