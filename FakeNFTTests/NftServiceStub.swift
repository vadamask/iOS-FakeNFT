//
//  NftServiceStub.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//

@testable import FakeNFT
import Foundation

final class NftServiceStub: NftService {
    private let networkClient: NetworkClient
    private let storage: NftStorage

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadNft(id: String, completion: @escaping NftCompletion) {
        completion(
            .success(
                Nft(
                    id: id,
                    name: "name \(id)",
                    images: [],
                    rating: 1,
                    description: "",
                    price: 1,
                    author: "",
                    createdAt: "")
            )
        )
    }
    
    func loadOrder(id: String, completion: @escaping OrderCompletion) {
        completion(.success(Order(id: "1", nfts: ["1", "2", "3"])))
    }
    
    func loadCurrencies(completion: @escaping CurrencyCompletion) {}
    func verifyPayment(with currencyID: String, completion: @escaping PaymentCompletion) {}
    func clearOrder(_ dto: FakeNFT.NftDto, completion: @escaping DeleteCompletion) {}
    func deleteNft(_ id: String, from ids: [String], completion: @escaping DeleteCompletion) {}
    func fakeRequest() {}
}
