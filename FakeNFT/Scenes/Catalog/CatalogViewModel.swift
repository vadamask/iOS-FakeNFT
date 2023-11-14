//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import Foundation
import Combine

enum CatalogViewModelState {
    case loading, error(Error), ready, sorting
}

enum CatalogViewModelSortingType: Int {
    case byNameAsc, byNameDesc, byNftCountAsc, byNftCountDesc
}

protocol CatalogViewModelProtocol {
    var state: CatalogViewModelState { get }
    var statePublisher: Published<CatalogViewModelState>.Publisher { get }
    var cellViewModels: [CatalogCellViewModel]? { get }
    func loadCollections()
    func changeSorting(to sortingType: CatalogViewModelSortingType)
}

final class CatalogViewModel: CatalogViewModelProtocol {
    private var subscriptions = Set<AnyCancellable>()
    private let service: NftService
    private let userDefaults = UserDefaults.standard
    private var sortingType: CatalogViewModelSortingType
    private(set) var cellViewModels: [CatalogCellViewModel]?
    @Published private(set) var state: CatalogViewModelState = .loading
    var statePublisher: Published<CatalogViewModelState>.Publisher { $state }

    init(service: NftService) {
        self.service = service
        sortingType = userDefaults.sortingType
    }

    func loadCollections() {
        state = .loading
        service.loadNftCollections()
            .map { nftCollections in
                nftCollections.map {
                    CatalogCellViewModel(
                        id: $0.id,
                        name: $0.name,
                        coverUrl: $0.cover,
                        nftCount: $0.nfts.count
                    )
                }
            }
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] cellModels in
                self?.cellViewModels = cellModels
                self?.sorting()
            }
            .store(in: &subscriptions)
    }

    func changeSorting(to sortingType: CatalogViewModelSortingType) {
        self.sortingType = sortingType
        userDefaults.sortingType = self.sortingType
        sorting()
    }

    private func sorting() {
        state = .sorting
        switch sortingType {
        case .byNameAsc:
            cellViewModels?.sort { $0.name.caseInsensitiveCompare($1.name) == .orderedAscending }
        case .byNameDesc:
            cellViewModels?.sort { $0.name.caseInsensitiveCompare($1.name) == .orderedDescending }
        case .byNftCountAsc:
            cellViewModels?.sort { $0.nftCount < $1.nftCount }
        case .byNftCountDesc:
            cellViewModels?.sort { $0.nftCount > $1.nftCount }
        }
        state = .ready
    }

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }
}
