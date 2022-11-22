//
//  Array+Replace.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

extension Array {
    /// - Parameter index: Index of an array you wish to replace.
    /// - Parameter element: New element to replace old element in array.
    mutating func replace(at index: Int, with element: Element) {
        self.replaceSubrange(index...index, with: [element])
    }
}
