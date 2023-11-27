//
//  CollectionCellViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 10.11.2023.
//

import Foundation

struct CollectionCellViewModel: Hashable {
    let id: String
    let imageUrls: [URL]
    var isLiked: Bool
    let name: String
    let rating: Int
    let price: Double
    var inOrder: Bool
}
