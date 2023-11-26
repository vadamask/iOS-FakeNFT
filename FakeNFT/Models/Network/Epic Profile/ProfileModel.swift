//
//  ProfileNetworkModel.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 12.11.2023.
//

import Foundation

struct ProfileModel: Codable {
    var name: String
    var avatar: String
    var description: String
    var website: String
    var nfts: [String]
    var likes: [String]
    var id: String
}
