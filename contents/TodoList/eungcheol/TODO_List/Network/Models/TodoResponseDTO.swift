//
//  TodoResponseDTO.swift
//  TODO_List
//
//  Created by 김응철 on 2022/11/27.
//

import Foundation

struct TodoResponseDTO: Decodable {
  let contents: String
  let id: Int
  let isCompleted: Bool
  let createdAt: String
  let updatedAt: String
}
