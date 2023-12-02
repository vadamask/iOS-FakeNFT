//
//  UserByIdRequest.swift
//  FakeNFT
//
//  Created by Artem Adiev on 12.11.2023.
//

import Foundation

struct UserByIdRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/users/\(id)")
    }
}
