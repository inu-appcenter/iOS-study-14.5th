//
//  decoding.swift
//  TodoList
//
//  Created by 김민정 on 2022/11/14.
//
import UIKit

func decoding() {
    
    do {
        let decoder = JSONDecoder()
        if let array = UserDefaults.standard.data(forKey: "memoInfo"){
            let data = try decoder.decode([MemoInfo].self, from: array)
            dummyMemoList = data
        }
        
    }catch{
        print(error)
        
    }
    

    
}

func encoding() {
    let encoder = JSONEncoder()

    /// encoded는 Data형
    if let encoded = try? encoder.encode(dummyMemoList) {
        UserDefaults.standard.set(encoded,forKey: "memoInfo")
        print("saving Success")
    }
    
}
