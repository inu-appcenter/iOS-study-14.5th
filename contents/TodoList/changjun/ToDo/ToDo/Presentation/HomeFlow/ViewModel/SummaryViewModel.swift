//
//  SummaryViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/24.
//

import Foundation

final class SummaryViewModel: ChildViewModel {
    
    // MARK: - Properties
    var parentViewModel: ViewModel?
    
    // MARK: - Observables
    
    // MARK: - Initializer
    init(parentViewModel: ViewModel?) {
        self.parentViewModel = parentViewModel
    }
    
    // MARK: - Functions
    func convertToPercentage(_ num: Int) -> Double {
        return (Double(num) / 100.0) * 360.0
    }
}
