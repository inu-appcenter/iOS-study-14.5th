//
//  Observable.swift
//  todoey
//
//  Created by 이창준 on 2022/11/19.
//

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
    
    func subscribe(listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}

