//
//  PutProfileRequest.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 14.11.2023.
//

import Foundation

struct PutProfileRequest: NetworkRequest {
    struct Body: Encodable {
        let name: String
        let description: String
        let website: String
        let likes: [String]
    }
    
    var endpoint: URL? {
        URL(string: "https://65450ba25a0b4b04436d87b8.mockapi.io/api/v1/profile/1")
    }
    
    var httpMethod: HttpMethod = .put
    
    var body: Data?
    
    init(
        name: String,
        description: String,
        website: String,
        likes: [String]
    ) {
        self.body = try? JSONEncoder().encode(Body(
            name: name,
            description: description,
            website: website,
            likes: likes
        ))
    }
}

