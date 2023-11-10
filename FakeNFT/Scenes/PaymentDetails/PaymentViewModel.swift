//
//  PaymentViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 10.11.2023.
//

import Foundation

final class PaymentViewModel {
    @Published var currencies: [Currency] = [
        Currency(id: "1", title: "Bitcoin", name: "BTC", image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"),
        Currency(id: "2", title: "Bitcoin", name: "BTC", image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"),
        Currency(id: "3", title: "Bitcoin", name: "BTC", image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"),
        Currency(id: "4", title: "Bitcoin", name: "BTC", image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png")
    
    ]
    
    
}
