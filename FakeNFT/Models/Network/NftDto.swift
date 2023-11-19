//
//  NftDto.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 11.11.2023.
//

import Foundation

struct NftDto: Encodable {
    let id: String
    let nfts: [String]
}
