final class ServicesAssembly {
    static let shared = ServicesAssembly()
    
    private let networkClient: NetworkClient = DefaultNetworkClient()
    private let nftStorage: NftStorage = NftStorageImpl()

    private init() {}

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
}
