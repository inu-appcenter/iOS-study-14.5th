//
//  HapticManager.swift
//  todoey
//
//  Created by 이창준 on 2022/11/14.
//

import UIKit

final class HapticManager {
    
    // MARK: - Singleton
    static let shared = HapticManager()
    
    // MARK: - Functions
    func impactFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let haptic = UIImpactFeedbackGenerator(style: style)
        haptic.impactOccurred()
    }
}
