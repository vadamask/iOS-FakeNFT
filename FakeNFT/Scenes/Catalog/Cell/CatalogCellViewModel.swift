//
//  CatalogCellViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import UIKit

struct CatalogCellViewModel: Hashable {
    let id: String
    let name: String
    let coverUrl: URL
    let nftCount: Int
}
