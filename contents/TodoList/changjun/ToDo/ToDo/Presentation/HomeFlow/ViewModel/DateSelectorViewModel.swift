//
//  DateSelectorViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

final class DateSelectorViewModel {
    
    // MARK: - Properties
    let dateSelectorUseCase: DateSelectorUseCase
    
    // MARK: - Initializer
    init(dateSelectorUseCase: DateSelectorUseCase) {
        self.dateSelectorUseCase = dateSelectorUseCase
    }
    
    // MARK: - Observables
    let currentTime: Observable<Date> = Observable(.now)
}
