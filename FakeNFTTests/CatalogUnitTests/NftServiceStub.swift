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
    func loadNft(id: String, completion: @escaping FakeNFT.NftCompletion) {}
    
    func loadNftCollections() -> AnyPublisher<[FakeNFT.NftCollection], NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftCollections") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode([NftCollection].self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadCollection(by id: String) -> AnyPublisher<FakeNFT.NftCollection, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftCollection") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(NftCollection.self, from: data) else {
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
    
    func loadUser(by id: String) -> AnyPublisher<FakeNFT.NftUser, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftUser") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(NftUser.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadProfile() -> AnyPublisher<FakeNFT.NftProfile, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftProfile") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(NftProfile.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func loadOrder(by id: String) -> AnyPublisher<FakeNFT.NftOrder, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftOrder") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(NftOrder.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func updateOrder(id: String, nftOrderDto: FakeNFT.NftOrderDto) -> AnyPublisher<FakeNFT.NftOrder, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftOrder") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(NftOrder.self, from: data) else {
                promise(.failure(NetworkClientError.parsingError))
                return
            }
            promise(.success(decodedData))
        }.eraseToAnyPublisher()
    }
    
    func updateProfile(nftProfileDto: FakeNFT.NftProfileDto) -> AnyPublisher<FakeNFT.NftProfile, NetworkClientError> {
        return Future { [weak self] promise in
            guard let data = self?.loadJson(filename: "NftProfile") else {
                promise(.failure(NetworkClientError.errorJsonLoad))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(NftProfile.self, from: data) else {
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
