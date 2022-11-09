//
//  SummaryView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/09.
//

import UIKit

class SummaryView: UIView {
    
    // MARK: - UI Components
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SummaryView {
    func configureUI() {
        
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct SummaryPreView: PreviewProvider {
    static var previews: some View {
        SummaryView().toPreview()
    }
}
#endif
