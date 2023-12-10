import Foundation
import Combine

typealias NftCompletion = (Result<Nft, Error>) -> Void
typealias OrderCompletion = (Result<Order, Error>) -> Void
typealias CurrencyCompletion = (Result<[Currency], Error>) -> Void
typealias PaymentCompletion = (Result<OrderPayment, Error>) -> Void
typealias DeleteCompletion = (Result<Void, Error>) -> Void
typealias ProfileCompletion = (Result<Profile, Error>) -> Void
typealias UserCompletion = (Result<User, Error>) -> Void

protocol NftService {
    func loadNft(id: String, completion: @escaping NftCompletion)
    func loadOrder(id: String, completion: @escaping OrderCompletion)
    func loadCurrencies(completion: @escaping CurrencyCompletion)
    func verifyPayment(with currencyID: String, completion: @escaping PaymentCompletion)
    func clearOrder(_ dto: OrderDto, completion: @escaping DeleteCompletion)
    func deleteNft(_ id: String, from ids: [String], completion: @escaping DeleteCompletion)
    
    func loadProfile(completion: @escaping ProfileCompletion)
    func updateProfile(nftProfileDto: ProfileDto, completion: @escaping ProfileCompletion)
    func updateLikes(likesProfileDto: ProfileLikesDto, completion: @escaping ProfileCompletion)
    
    func loadNftCollections() -> AnyPublisher<[Collection], NetworkClientError>
    func loadCollection(by id: String) -> AnyPublisher<Collection, NetworkClientError>
    func loadNft(by id: String) -> AnyPublisher<Nft, NetworkClientError>
    func loadUser(by id: String) -> AnyPublisher<User, NetworkClientError>
    func loadProfile() -> AnyPublisher<Profile, NetworkClientError>
    func loadOrder(by id: String) -> AnyPublisher<Order, NetworkClientError>
    func updateOrder(id: String, nftOrderDto: OrderDto) -> AnyPublisher<Order, NetworkClientError>
    func updateProfile(nftProfileDto: ProfileDto) -> AnyPublisher<Profile, NetworkClientError>
    func loadUser(by id: String, completion: @escaping UserCompletion)
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
    
    func loadOrder(id: String, completion: @escaping OrderCompletion) {
        let request = OrderRequest(id: id)
        networkClient.send(request: request, type: Order.self) { result in
            switch result {
            case .success(let order):
                completion(.success(order))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadCurrencies(completion: @escaping CurrencyCompletion) {
        let request = CurrencyRequest()
        networkClient.send(request: request, type: [Currency].self) { result in
            switch result {
            case .success(let currencies):
                completion(.success(currencies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func verifyPayment(with currencyID: String, completion: @escaping PaymentCompletion) {
        let request = PaymentRequest(id: currencyID)
        networkClient.send(request: request, type: OrderPayment.self) { result in
            switch result {
            case .success(let orderPayment):
                completion(.success(orderPayment))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func clearOrder(_ dto: OrderDto, completion: @escaping DeleteCompletion) {
        let request = OrderRequest(id: "1", httpMethod: .put, dto: dto)
        networkClient.send(request: request) { result in
            switch result {
            case .success:
                completion(.success(Void()))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteNft(_ id: String, from ids: [String], completion: @escaping DeleteCompletion) {
        let dto = OrderDto(nfts: ids.filter { $0 != id })
        let request = OrderRequest(id: "1", httpMethod: .put, dto: dto)
        networkClient.send(request: request) { result in
            switch result {
            case .success:
                completion(.success(Void()))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        networkClient.send(request: ProfileRequest(), type: Profile.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadUser(by id: String, completion: @escaping UserCompletion) {
        networkClient.send(request: UserByIdRequest(id: id), type: User.self) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateProfile(nftProfileDto: ProfileDto, completion: @escaping ProfileCompletion) {
        let request = ProfileRequest(httpMethod: .put, dto: nftProfileDto)
        networkClient.send(request: request, type: Profile.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateLikes(likesProfileDto: ProfileLikesDto, completion: @escaping ProfileCompletion) {
        let request = ProfileRequest(httpMethod: .put, dto: likesProfileDto)
        networkClient.send(request: request, type: Profile.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadNftCollections() -> AnyPublisher<[Collection], NetworkClientError> {
        let request = NftCollectionRequest()
        return networkClient.send(request: request)
    }
    func loadCollection(by id: String) -> AnyPublisher<Collection, NetworkClientError> {
        let request = NftCollectionIdRequest(id: id)
        return networkClient.send(request: request)
    }
    func loadNft(by id: String) -> AnyPublisher<Nft, NetworkClientError> {
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
    func loadUser(by id: String) -> AnyPublisher<User, NetworkClientError> {
        let request = UserByIdRequest(id: id)
        return networkClient.send(request: request)
    }
    func loadOrder(by id: String) -> AnyPublisher<Order, NetworkClientError> {
        let request = OrderRequest(id: id)
        return networkClient.send(request: request)
    }
    func updateOrder(id: String, nftOrderDto: OrderDto) -> AnyPublisher<Order, NetworkClientError> {
        let request = OrderRequest(id: id, httpMethod: .put, dto: nftOrderDto)
        return networkClient.send(request: request)
    }
    func loadProfile() -> AnyPublisher<Profile, NetworkClientError> {
        let request = ProfileRequest()
        return networkClient.send(request: request)
    }
    func updateProfile(nftProfileDto: ProfileDto) -> AnyPublisher<Profile, NetworkClientError> {
        let request = ProfileRequest(httpMethod: .put, dto: nftProfileDto)
        return networkClient.send(request: request)
    }
}
