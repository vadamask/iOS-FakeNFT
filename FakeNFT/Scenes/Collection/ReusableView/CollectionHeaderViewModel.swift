//
//  CollectionHeaderViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 13.11.2023.
//

import Foundation

struct CollectionHeaderViewModel: Hashable {
    let name: String
    var author: String
    let description: String
    let cover: URL
    var webSite: URL?
}
