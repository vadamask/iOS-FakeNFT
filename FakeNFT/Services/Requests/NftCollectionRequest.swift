//
//  NftCollectionRequest.swift
//  FakeNFT
//
//  Created by Виктор on 08.11.2023.
//

import Foundation

struct NftCollectionRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections")
    }
}
