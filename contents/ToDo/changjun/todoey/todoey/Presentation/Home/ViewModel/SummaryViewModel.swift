//
//  SummaryViewModel.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import Foundation

struct SummaryViewModel {
    var progressPercentage: String {
        return "70%"
    }
    
    var staticText: (String, String) {
        return ("오늘 할 일", "완료")
    }
}
