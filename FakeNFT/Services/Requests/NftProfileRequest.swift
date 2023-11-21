//
//  NftProfileRequest.swift
//  FakeNFT
//
//  Created by Виктор on 14.11.2023.
//

import Foundation

struct NftProfileRequest: NetworkRequest {
    var httpMethod: HttpMethod = .get
    var dto: Encodable?

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}
