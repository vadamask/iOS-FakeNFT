//
//  NftOrder.swift
//  FakeNFT
//
//  Created by Виктор on 14.11.2023.
//

import Foundation

struct NftOrder: Decodable {
    let id: String
    let nfts: [String]
}
