import Foundation
import Combine

typealias NftCompletion = (Result<Nft, Error>) -> Void
typealias NftCollectionCompletion = (Result<[NftCollection], Error>) -> Void

protocol NftService {
    func loadNft(id: String, completion: @escaping NftCompletion)
    func loadNftCollections() -> AnyPublisher<[NftCollection], Error>
    func loadCollection(by id: String) -> AnyPublisher<NftCollection, Error>
    func loadNft(by id: String) -> AnyPublisher<Nft, Error>
    func loadUser(by id: String) -> AnyPublisher<NftUser, Error>
    func loadProfile() -> AnyPublisher<NftProfile, Error>
    func loadOrder(by id: String) -> AnyPublisher<NftOrder, Error>
}

final class NftServiceImpl: NftService {
    private let networkClient: NetworkClient
    private let storage: NftStorage

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNft(id: String, completion: @escaping NftCompletion) {
        if let nft = storage.getNft(with: id) {
            completion(.success(nft))
            return
        }

        let request = NFTRequest(id: id)
        networkClient.send(request: request, type: Nft.self) { [weak storage] result in
            switch result {
            case .success(let nft):
                storage?.saveNft(nft)
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadNftCollections() -> AnyPublisher<[NftCollection], Error> {
        let request = NftCollectionRequest()
        return networkClient.send(request: request)
    }
    func loadCollection(by id: String) -> AnyPublisher<NftCollection, Error> {
        let request = NftCollectionIdRequest(id: id)
        return networkClient.send(request: request)
    }
    func loadNft(by id: String) -> AnyPublisher<Nft, Error> {
        if let nft = storage.getNft(with: id) {
            return Future { promise in
                promise(.success(nft))
            }
            .eraseToAnyPublisher()
        }
        let request = NFTRequest(id: id)
        return networkClient.send(request: request)
            .map { [weak self] nft in
                self?.storage.saveNft(nft)
                return nft
            }
        .eraseToAnyPublisher()
    }
    func loadUser(by id: String) -> AnyPublisher<NftUser, Error> {
        let request = NftUserRequest(id: id)
        return networkClient.send(request: request)
    }
    func loadOrder(by id: String) -> AnyPublisher<NftOrder, Error> {
        let request = NftOrderRequest(id: id)
        return networkClient.send(request: request)
    }
    func loadProfile() -> AnyPublisher<NftProfile, Error> {
        let request = NftProfileRequest()
        return networkClient.send(request: request)
    }
}
