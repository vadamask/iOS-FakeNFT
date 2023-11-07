//
//  Order.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 06.11.2023.
//

import Foundation

struct Order: Decodable {
    let id: String
    let nfts: [String]
}
