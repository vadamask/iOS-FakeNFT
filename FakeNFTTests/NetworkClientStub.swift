//
//  NetworkClientStub.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//

import Foundation
@testable import FakeNFT

final class NetworkClientStub: NetworkClient {
    func send<T>(
        request: NetworkRequest,
        type: T.Type,
        completionQueue: DispatchQueue,
        onResponse: @escaping (Result<T, Error>) -> Void
    ) -> NetworkTask? where T: Decodable {
        return nil
    }
    
    func send(
        request: NetworkRequest,
        completionQueue: DispatchQueue,
        onResponse: @escaping (Result<Data, Error>) -> Void
    ) -> NetworkTask? {
        return nil
    }
}
