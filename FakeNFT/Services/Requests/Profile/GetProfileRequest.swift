//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 14.11.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var httpMethod: HttpMethod
    var dto: Encodable?
    var endpoint: URL? {
        NetworkConstants.baseURL.appendingPathComponent(NetworkConstants.profileEndpoint)
    }
}
