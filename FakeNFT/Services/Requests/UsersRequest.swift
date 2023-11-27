//
//  UsersRequest.swift
//  FakeNFT
//
//  Created by Artem Adiev on 08.11.2023.
//

import Foundation

struct UsersRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/users")
    }
}
