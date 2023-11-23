//
//  CollectionCellViewModel.swift
//  FakeNFT
//
//  Created by Artem Adiev on 17.11.2023.
//

import Foundation

struct CollectionCellViewModel: Hashable {
    let imageUrls: [URL]
    let isLiked: Bool
    let name: String
    let rating: Int
    let price: Double
    let inOrder: Bool
}
