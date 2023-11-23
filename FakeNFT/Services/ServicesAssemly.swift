protocol ServicesAssemblyProtocol {
    var nftService: NftService { get }
}

final class ServicesAssembly: ServicesAssemblyProtocol { 
    private let networkClient: NetworkClient = DefaultNetworkClient()
    private let nftStorage: NftStorage = NftStorageImpl()

    init() {}

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
}
