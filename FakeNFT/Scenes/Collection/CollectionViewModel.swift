//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 12.11.2023.
//

import Foundation
import Combine

enum CollectionViewState {
    case initial, loading, loaded, error(Error)
}

protocol CollectionViewModelProtocol {
    var state: CurrentValueSubject<CollectionViewState, Never> { get }
    var cellViewModels: [CollectionCellViewModel] { get }
    var headerViewModel: CollectionHeaderViewModel? { get }
    func loadCollection()
    func likeNftWith(id: String, isLiked: Bool)
    func addToCartNftWith(id: String)
    func removeFromCartNftWith(id: String)
    func navigateToAuthorPage(url: URL)
}

final class CollectionViewModel: CollectionViewModelProtocol {
    weak var navigation: CollectionNavigation?
    private var subscriptions = Set<AnyCancellable>()
    private let collectionId: String
    private let service: NftService
    private(set) var cellViewModels: [CollectionCellViewModel] = []
    private(set) var headerViewModel: CollectionHeaderViewModel?
    private(set) var state = CurrentValueSubject<CollectionViewState, Never>(.initial)

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }

    init(collectionId: String, service: NftService, navigation: CollectionNavigation) {
        self.collectionId = collectionId
        self.service = service
        self.navigation = navigation
        self.headerViewModel = CollectionHeaderViewModel(
            name: "",
            author: "",
            description: "",
            cover: nil
        )
        for i in 0...5 {
            self.cellViewModels.append(
                CollectionCellViewModel(
                    id: "\(i)",
                    imageUrls: [],
                    isLiked: false,
                    name: "",
                    rating: 0,
                    price: 0,
                    inOrder: false
                )
            )
        }
    }

    func loadCollection() {
        state.value = .loading
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
                                id: $0.id,
                                imageUrls: $0.images,
                                isLiked: profile.likes.contains($0.id),
                                name: $0.name,
                                rating: $0.rating,
                                price: $0.price,
                                inOrder: order.nfts.contains($0.id))
                        }
                        .sorted { $0.name < $1.name }
                        return (headerVM, cellVM)
                    }
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state.value = .error(error)
                }
            } receiveValue: { [weak self] headerVM, cellVM in
                self?.headerViewModel = headerVM
                self?.cellViewModels = cellVM
                self?.state.value = .loaded
            }
            .store(in: &subscriptions)
    }

    func likeNftWith(id: String, isLiked: Bool) {
        service.loadProfile()
            .flatMap { [unowned self] profile -> AnyPublisher<NftProfile, Error> in
                var likes = profile.likes
                if isLiked {
                    likes.append(id)
                } else {
                    likes.removeAll { $0 == id }
                }
                let profileDto = NftProfileDto(
                    name: profile.name,
                    description: profile.description,
                    website: profile.website.description,
                    likes: likes
                )
                return self.service.updateProfile(nftProfileDto: profileDto)
            }
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state.value = .error(error)
                }
            } receiveValue: { [weak self] profile in
                guard let self = self else { return }
                for i in 0..<self.cellViewModels.count {
                    self.cellViewModels[i].isLiked = profile.likes.contains(self.cellViewModels[i].id)
                }
                self.state.value = .loaded
            }
            .store(in: &subscriptions)
    }

    func addToCartNftWith(id: String) {
        service.loadOrder(by: "1")
            .flatMap { [unowned self] order in
                var nfts = order.nfts
                nfts.append(id)
                let orderDto = NftOrderDto(nfts: nfts)
                return service.updateOrder(id: order.id, nftOrderDto: orderDto)
            }
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state.value = .error(error)
                }
            } receiveValue: { [weak self] order in
                guard let self = self else { return }
                for i in 0..<self.cellViewModels.count {
                    self.cellViewModels[i].inOrder = order.nfts.contains(self.cellViewModels[i].id)
                }
                self.state.value = .loaded
            }
            .store(in: &subscriptions)
    }
    
    func removeFromCartNftWith(id: String) {
        service.loadOrder(by: "1")
            .flatMap { [unowned self] order in
                var nfts = order.nfts
                nfts.removeAll { $0 == id }
                let orderDto = NftOrderDto(nfts: nfts)
                return service.updateOrder(id: order.id, nftOrderDto: orderDto)
            }
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state.value = .error(error)
                }
            } receiveValue: { [weak self] order in
                guard let self = self else { return }
                for i in 0..<self.cellViewModels.count {
                    self.cellViewModels[i].inOrder = order.nfts.contains(self.cellViewModels[i].id)
                }
                self.state.value = .loaded
            }
            .store(in: &subscriptions)
    }

    func navigateToAuthorPage(url: URL) {
        navigation?.goToAuthorPage(url: url)
    }
}
