//
//  NftProfileRequest.swift
//  FakeNFT
//
//  Created by Виктор on 14.11.2023.
//

import Foundation

struct NftProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}
