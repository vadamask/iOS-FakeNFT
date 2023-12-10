//
//  CurrencyRequest.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 10.11.2023.
//

import Foundation

struct CurrencyRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
    }
}
