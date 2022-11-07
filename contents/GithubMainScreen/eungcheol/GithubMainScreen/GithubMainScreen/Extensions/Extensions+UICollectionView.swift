import UIKit

extension UICollectionView {
  static func pinnedCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .absolute(300),
      heightDimension: .absolute(120)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .absolute(300),
      heightDimension: .absolute(120)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 8
    section.orthogonalScrollingBehavior = .groupPaging
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
}
