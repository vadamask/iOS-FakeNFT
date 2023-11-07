//
//  Users.swift
//  FakeNFT
//
//  Created by Artem Adiev on 07.11.2023.
//

import Foundation

struct Users: Decodable {
    let name: String
    let avatar: URL
    let description: String
    let website: URL
    let nfts: [String]
    let rating: String
    let id: String
}
