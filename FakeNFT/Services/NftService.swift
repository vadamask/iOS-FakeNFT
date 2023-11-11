import Foundation

typealias NftCompletion = (Result<Nft, Error>) -> Void
typealias OrderCompletion = (Result<Order, Error>) -> Void
typealias CurrencyCompletion = (Result<[Currency], Error>) -> Void
typealias PaymentCompletion = (Result<OrderPayment, Error>) -> Void

protocol NftService {
    func loadNft(id: String, completion: @escaping NftCompletion)
    func loadOrder(id: String, completion: @escaping OrderCompletion)
    func loadCurrencies(completion: @escaping CurrencyCompletion)
    func verifyPayment(with currencyID: String, completion: @escaping PaymentCompletion)
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
}
