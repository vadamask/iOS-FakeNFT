//
//  NFTNetworkModel.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 19.11.2023.
//

import Foundation

struct NFTNetworkModel: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
