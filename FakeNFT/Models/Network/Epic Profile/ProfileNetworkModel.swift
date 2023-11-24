//
//  ProfileNetworkModel.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 12.11.2023.
//

import Foundation

struct ProfileNetworkModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
