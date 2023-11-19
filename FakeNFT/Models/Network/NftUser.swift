//
//  NftUser.swift
//  FakeNFT
//
//  Created by Виктор on 13.11.2023.
//

import Foundation

struct NftUser: Decodable {
    let id: String
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let rating: String
}
