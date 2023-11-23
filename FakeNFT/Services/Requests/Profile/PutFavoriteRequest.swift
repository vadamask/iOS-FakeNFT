//
//  PutFavoriteRequest.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 22.11.2023.
//

import Foundation

struct PutFavoritesRequest: NetworkRequest {
    struct Body: Encodable {
        let likes: [String]
    }

    var endpoint: URL? {
        NetworkConstants.baseURL.appendingPathComponent(NetworkConstants.profileEndpoint)
    }

    var httpMethod: HttpMethod = .put

    var body: Data?

    init(
        likes: [String]
    ) {
        self.body = try? JSONEncoder().encode(Body(
            likes: likes
        ))
    }
}
