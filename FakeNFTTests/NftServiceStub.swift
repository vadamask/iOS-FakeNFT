//
//  NftServiceSpy.swift
//  FakeNFTTests
//
//  Created by Виктор on 24.11.2023.
//

@testable import FakeNFT
import Foundation
import Combine

final class NftServiceStub: NftService {
    func loadCurrencies(completion: @escaping FakeNFT.CurrencyCompletion) {}
    
    func verifyPayment(with currencyID: String, completion: @escaping FakeNFT.PaymentCompletion) {}
    
    func clearOrder(_ dto: FakeNFT.OrderDto, completion: @escaping FakeNFT.DeleteCompletion) {}
    
    func deleteNft(_ id: String, from ids: [String], completion: @escaping FakeNFT.DeleteCompletion) {}
    
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

    func loadNftCollections() -> AnyPublisher<[Collection], NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftCollections") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode([Collection].self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadCollection(by id: String) -> AnyPublisher<Collection, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftCollection") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(Collection.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadNft(by id: String) -> AnyPublisher<FakeNFT.Nft, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "Nft") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(Nft.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadUser(by id: String) -> AnyPublisher<User, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftUser") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(User.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadProfile() -> AnyPublisher<Profile, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftProfile") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(Profile.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadOrder(by id: String) -> AnyPublisher<Order, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftOrder") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(Order.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func updateOrder(id: String, nftOrderDto: OrderDto) -> AnyPublisher<Order, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftOrder") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(Order.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func updateProfile(nftProfileDto: ProfileDto) -> AnyPublisher<Profile, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftProfile") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(Profile.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }

    private func loadJson(filename: String) -> Data? {
        guard let path = Bundle(for: Self.self).url(forResource: filename, withExtension: "json") else {
            return nil
        }
        return try? Data(contentsOf: path)
    }
}
