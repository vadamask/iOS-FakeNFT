//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 12.11.2023.
//

import Foundation
import Combine

enum CollectionViewState {
    case loading, loaded, error(Error)
}

protocol CollectionViewModelProtocol {
    var state: CollectionViewState { get }
    var statePublisher: Published<CollectionViewState>.Publisher { get }
    var cellViewModels: [CollectionCellViewModel]? { get }
    var headerViewModel: CollectionHeaderViewModel? { get }
    func loadCollection()
}

final class CollectionViewModel: CollectionViewModelProtocol {
    private var subscriptions = Set<AnyCancellable>()
    private let collectionId: String
    private let service: NftService
    private(set) var cellViewModels: [CollectionCellViewModel]?
    private(set) var headerViewModel: CollectionHeaderViewModel?
    @Published private(set) var state: CollectionViewState = .loading
    var statePublisher: Published<CollectionViewState>.Publisher { $state }

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }

    init(collectionId: String, service: NftService) {
        self.collectionId = collectionId
        self.service = service
    }

    func loadCollection() {
        service.loadCollection(by: collectionId)
            .flatMap { [unowned self] collection in
                let user = self.service.loadUser(by: collection.author)
                let profile = self.service.loadProfile()
                let order = self.service.loadOrder(by: "1")
                let nfts = collection.nfts.map { self.service.loadNft(by: $0) }
                let nftsMerge = Publishers.MergeMany(nfts).collect().eraseToAnyPublisher()
                return Publishers.Zip4(user, nftsMerge, order, profile)
                    .map { nftUser, nfts, order, profile in
                        let headerVM = CollectionHeaderViewModel(
                            name: collection.name,
                            author: nftUser.name,
                            description: collection.description,
                            cover: collection.cover,
                            webSite: nftUser.website
                        )
                        let cellVM = nfts.map {
                            CollectionCellViewModel(
                                imageUrls: $0.images,
                                isLiked: profile.likes.contains($0.id),
                                name: $0.name,
                                rating: $0.rating,
                                price: $0.price,
                                inOrder: order.nfts.contains($0.id))
                        }
                        return (headerVM, cellVM)
                    }
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] headerVM, cellVM in
                self?.headerViewModel = headerVM
                self?.cellViewModels = cellVM
                self?.state = .loaded
            }
            .store(in: &subscriptions)
    }
}
