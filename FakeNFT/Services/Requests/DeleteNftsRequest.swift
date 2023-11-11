//
//  DeleteNftsRequest.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 11.11.2023.
//

import Foundation

struct DeleteNftsRequest: NetworkRequest {
    var httpMethod: HttpMethod = .put
    var dto: Encodable?
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}
