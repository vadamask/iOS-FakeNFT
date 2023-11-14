//
//  NftOrderRequest.swift
//  FakeNFT
//
//  Created by Виктор on 14.11.2023.
//

import Foundation

struct NftOrderRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/\(id)")
    }
}
