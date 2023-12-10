//
//  CatalogLayout.swift
//  FakeNFT
//
//  Created by Виктор on 14.11.2023.
//

import UIKit

final class CatalogLayout: UICollectionViewCompositionalLayout {
    convenience init() {
        let layout = {
            let heightDimension = NSCollectionLayoutDimension.estimated(200)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: heightDimension
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: heightDimension
            )
            var group: NSCollectionLayoutGroup
            if #available(iOS 16.0, *) {
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            } else {
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            }
            group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            group.interItemSpacing = .fixed(8)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 20
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
}
