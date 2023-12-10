//
//  NftCollectionRequest.swift
//  FakeNFT
//
//  Created by Виктор on 12.11.2023.
//

import Foundation

struct NftCollectionIdRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections/\(id)")
    }
}
