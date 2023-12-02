//
//  OrderPayment.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 11.11.2023.
//

import Foundation

struct OrderPayment: Decodable {
    let success: Bool
    let id: String
    let orderId: String
}
