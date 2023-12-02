//
//  Currency.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 10.11.2023.
//

import Foundation

struct Currency: Hashable & Decodable {
    let id: String
    let title: String
    let name: String
    let image: String
}
