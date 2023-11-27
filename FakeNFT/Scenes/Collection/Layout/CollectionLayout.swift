//
//  CustomLayout.swift
//  FakeNFT
//
//  Created by Виктор on 10.11.2023.
//

import UIKit

final class CollectionLayout: UICollectionViewCompositionalLayout {
    private var headerInitialHeight: CGFloat?

    convenience init() {
        let layout = {
            let heightDimension = NSCollectionLayoutDimension.estimated(200)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 3),
                heightDimension: heightDimension
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: heightDimension
            )
            var group: NSCollectionLayoutGroup
            if #available(iOS 16.0, *) {
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            } else {
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            }
            group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            group.interItemSpacing = .fixed(8)
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1 / 2))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 28
            section.boundarySupplementaryItems = [sectionHeader]
            section.contentInsets.top = 24
            return section
        }
        self.init(section: layout())
    }

    override init(section: NSCollectionLayoutSection) {
        super.init(section: section)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)

        layoutAttributes?.forEach { attribute in
            if
                attribute.representedElementKind == UICollectionView.elementKindSectionHeader,
                attribute.indexPath.section == 0 {
                guard let collectionView = collectionView else { return }

                let contentOffsetY = collectionView.contentOffset.y

                if contentOffsetY > 0 {
                    return
                }

                if headerInitialHeight == nil {
                    headerInitialHeight = attribute.frame.height
                }

                guard let headerInitialHeight = headerInitialHeight else { return }
                let width = collectionView.frame.width
                let height = headerInitialHeight - contentOffsetY

                attribute.frame = .init(x: 0, y: contentOffsetY, width: width, height: height)
            }
        }

        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
}
