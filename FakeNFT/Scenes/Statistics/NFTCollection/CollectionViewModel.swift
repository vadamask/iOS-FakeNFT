//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Artem Adiev on 15.11.2023.
//

import Foundation

final class CollectionViewModel {
    // MARK: - Properties
    private var networkClient: NetworkClient
    private var nftIds: [String]
    var nftCollection: [Nft] = [] {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    var reloadCollectionViewClosure: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?

    // MARK: - Init
    init(networkClient: NetworkClient, nftIds: [String]) {
        self.networkClient = networkClient
        self.nftIds = nftIds
    }

    // MARK: - Data fetching
    func fetchNftCollection() {
        guard !nftIds.isEmpty else { return }

        showLoading?()
        nftCollection.removeAll()

        // Создаем группу для отслеживания множественных асинхронных запросов
        let fetchGroup = DispatchGroup()

        for nftId in nftIds {
            fetchGroup.enter()
            let request = NFTRequest(id: nftId)
            print("Fetching NFT with ID: \(nftId)")
            networkClient.send(request: request, type: Nft.self) { [weak self] result in
                defer { fetchGroup.leave() }

                switch result {
                case .success(let nft):
                    DispatchQueue.main.async {
                        self?.nftCollection.append(nft)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Error fetching NFT with id \(nftId): \(error.localizedDescription)")
                        print("АДРЕС: \(request)")
                    }
                }
            }
        }
        // Когда все запросы завершены, мы скрываем индикатор загрузки
        fetchGroup.notify(queue: .main) {
            self.hideLoading?()
        }
    }
}
