//
//  NetworkClientStub.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//

import Foundation
@testable import FakeNFT
import Combine

final class NetworkClientStub: NetworkClient {
    func send<T>(request: FakeNFT.NetworkRequest) -> AnyPublisher<T, FakeNFT.NetworkClientError> where T : Decodable {
        return Future { promise in
            promise(.failure(NetworkClientError.errorJsonLoad))
        }
        .eraseToAnyPublisher()
    }
    
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
