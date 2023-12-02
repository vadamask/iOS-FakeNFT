//
//  NftProfileDto.swift
//  FakeNFT
//
//  Created by Виктор on 21.11.2023.
//

import Foundation

struct ProfileDto: Encodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let likes: [String]
}
