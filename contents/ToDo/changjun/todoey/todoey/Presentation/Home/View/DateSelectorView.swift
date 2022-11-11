//
//  DateSelectorCollectionView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

import SnapKit
import Then

class DateSelectorView: UIView {
    
    private var viewModel = DateSelectorViewModel()
    
    // MARK: - UI Components
    lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(DateSelectorCell.self, forCellWithReuseIdentifier: DateSelectorCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 90)
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
private extension DateSelectorView {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        self.addSubview(self.collectionView)
    }
    
    func configureConstraints() {
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    func configureStyles() {
        
    }
}

// MARK: - Collection View
extension DateSelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DateSelectorCell.identifier, for: indexPath
        ) as? DateSelectorCell else {
            return UICollectionViewCell()
        }
        cell.dayLabel.text = self.viewModel.dayString
        cell.dayOfWeekLabel.text = self.viewModel.dayOfWeekString
        return cell
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct DateSelectorPreView: PreviewProvider {
    static var previews: some View {
        DateSelectorView().toPreview()
    }
}
#endif
