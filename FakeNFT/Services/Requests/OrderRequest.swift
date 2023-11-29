//
//  NftOrderRequest.swift
//  FakeNFT
//
//  Created by Виктор on 14.11.2023.
//

import Foundation

struct OrderRequest: NetworkRequest {
    let id: String
    var httpMethod: HttpMethod = .get
    var dto: Encodable?

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/\(id)")
    }
}
