//
//  ServicesAssemblyStub.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//

import Foundation
@testable import FakeNFT

final class ServicesAssemblyStub: ServicesAssemblyProtocol {
    private let networkClient: NetworkClient = NetworkClientStub()
    private let nftStorage: NftStorage = NftStorageImpl()
    init() {}
    
    var nftService: NftService {
        NftServiceStub(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
}
