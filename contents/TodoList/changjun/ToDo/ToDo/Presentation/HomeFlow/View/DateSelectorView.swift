//
//  DateSelectorCollectionView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

import SnapKit

class DateSelectorView: UIView {
    
    // MARK: - Properties
    var viewModel: DateSelectorViewModel?
    
    // MARK: - UI Components
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            DateSelectorCell.self,
            forCellWithReuseIdentifier: DateSelectorCell.identifier
        )
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Initializers
    convenience init(dateSelectorViewModel: DateSelectorViewModel) {
        self.init(frame: .zero)
        self.viewModel = dateSelectorViewModel
    }
    
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
        self.backgroundColor = .clear
    }
}

// MARK: - Collection View
extension DateSelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 7 // dayOfWeek
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DateSelectorCell.identifier, for: indexPath
        ) as? DateSelectorCell else {
            return UICollectionViewCell()
        }
        self.viewModel?.currentTime.subscribe { date in
            if let dateOfCell = Calendar.current.date(
                byAdding: .day,
                value: indexPath.item - 3,
                to: date) {
                cell.dateOfCell = dateOfCell
            }
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        guard let cell = collectionView.cellForItem(at: indexPath) as? DateSelectorCell else { return }
    }
}

// MARK: - Collection View Flow Layout
extension DateSelectorView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 60, height: 90)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}
