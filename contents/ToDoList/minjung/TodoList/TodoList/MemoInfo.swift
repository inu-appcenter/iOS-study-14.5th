//
//  memoInfo.swift
//  TodoList
//
//  Created by 김민정 on 2022/11/08.
//  SingleTon - 메모의 제목과 date를 전역적으로 사용

import UIKit


struct MemoInfo:Codable{
    
    
    var title : String? // 메모 제목
    var date : String? // 메모 작성 날짜
    var content : String? // 메모 내용
    var identifier : Int?
    
    init(memotitle:String = "", memocontent:String = "", memodate:String = "") {
        self.title = memotitle
        self.date = memodate
        self.content = memocontent
        self.identifier = Int(Date().timeIntervalSince1970)
        
    }
    
    
}


