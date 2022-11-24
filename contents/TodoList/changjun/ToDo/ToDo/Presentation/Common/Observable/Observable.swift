//
//  Observable.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/22.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func subscribe(listener: @escaping ((T) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
