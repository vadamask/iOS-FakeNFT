//
//  NftCollection.swift
//  FakeNFT
//
//  Created by Виктор on 07.11.2023.
//

import Foundation

struct NftCollection: Decodable {
    let id: String
    let name: String
    let cover: URL
    let author: String
    let description: String
    let nfts: [String]
    let createdAt: String
}
