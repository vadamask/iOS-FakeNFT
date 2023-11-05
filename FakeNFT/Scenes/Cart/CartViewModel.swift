//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 05.11.2023.
//

import UIKit

struct CartCellModel {
    let image: UIImage
    let name: String
    let rating: Int
    let price: Double
    let currency: String
}

final class CartViewModel {
    var nft: [CartCellModel] = [
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 1, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 2, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 3, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 1, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 1, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 1, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 1, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 1, price: 1.78, currency: "ETH"),
        CartCellModel(image: Asset.beigeApril.image, name: "1", rating: 1, price: 1.78, currency: "ETH")
    ]
    private let servicesAssembly: ServicesAssembly
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
}
