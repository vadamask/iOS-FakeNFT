//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 14.11.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://65450ba25a0b4b04436d87b8.mockapi.io/api/v1/profile/1")
    }
}
