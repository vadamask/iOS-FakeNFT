//
//  NftUserRequest.swift
//  FakeNFT
//
//  Created by Виктор on 13.11.2023.
//

import Foundation

struct NftUserRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/users/\(id)")
    }
}
