//
//  VC2Func.swift
//  TodoList
//
//  Created by 김민정 on 2022/11/09.


import Foundation

func DateType2String() -> String{
    let current = Date()
    
    let formatter = DateFormatter()
    //한국 시간으로 표시
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.timeZone = TimeZone(abbreviation: "KST")
    //형태 변환
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return formatter.string(from: current)
}
