//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import Foundation
import Combine

enum CatalogViewModelState {
    case initial, loading, refreshing, error(Error), ready, sorting
}

enum CatalogViewModelSortingType: Int {
    case byNameAsc, byNameDesc, byNftCountAsc, byNftCountDesc
}

protocol CatalogViewModelProtocol: AnyObject {
    var state: CurrentValueSubject<CatalogViewModelState, Never> { get }
    var cellViewModels: [CatalogCellViewModel] { get }
    func loadCollections()
    func refreshCollections()
    func changeSorting(to sortingType: CatalogViewModelSortingType)
    func navigateToCollectionWith(id: String)
}

final class CatalogViewModel: CatalogViewModelProtocol {
    weak var navigation: CatalogNavigation?
    private var loadSubscription: AnyCancellable?
    private var subscriptions = Set<AnyCancellable>()
    private let service: NftService
    private let userDefaults = UserDefaults.standard
    private var currentSortingType: CatalogViewModelSortingType
    private var sortingTypePublisher = PassthroughSubject<CatalogViewModelSortingType, Never>()
    private(set) var cellViewModels: [CatalogCellViewModel] = []
    private(set) var state = CurrentValueSubject<CatalogViewModelState, Never>(.initial)

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }
    
    init(service: NftService, navigation: CatalogNavigation?) {
        self.service = service
        self.navigation = navigation
        self.currentSortingType = userDefaults.catalogSortingType

        for i in 0...4 {
            self.cellViewModels.append(
                CatalogCellViewModel(id: "\(i)", name: "", coverUrl: nil, nftCount: 0)
            )
        }

        // MARK: For background sorting
        self.sortingTypePublisher
            .receive(on: DispatchQueue.global())
            .flatMap { [unowned self] sortingType in
                sorting(viewModels: self.cellViewModels, with: sortingType)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sortedCells in
                self?.cellViewModels = sortedCells
                self?.state.value = .ready
            }
            .store(in: &subscriptions)
    }

    func loadCollections() {
        state.value = .loading
        fetchCollections()
    }

    func refreshCollections() {
        state.send(.refreshing)
        fetchCollections()
    }

    func changeSorting(to sortingType: CatalogViewModelSortingType) {
        currentSortingType = sortingType
        userDefaults.catalogSortingType = sortingType
        self.sortingTypePublisher.send(sortingType)
    }

    private func fetchCollections() {
        loadSubscription = service.loadNftCollections()
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
                    self?.state.value = .error(error)
                }
                self?.loadSubscription?.cancel()
            } receiveValue: { [weak self] cellModels in
                guard let self = self else { return }
                self.cellViewModels = cellModels
                self.sortingTypePublisher.send(self.currentSortingType) // Due to iOS 13 support
            }
    }

    private func sorting(viewModels: [CatalogCellViewModel], with sortingType: CatalogViewModelSortingType) -> Just<[CatalogCellViewModel]> {
        state.value = .sorting
        let sorted: [CatalogCellViewModel]
        switch sortingType {
        case .byNameAsc:
            sorted = viewModels.sorted { $0.name.caseInsensitiveCompare($1.name) == .orderedAscending }
        case .byNameDesc:
            sorted = viewModels.sorted { $0.name.caseInsensitiveCompare($1.name) == .orderedDescending }
        case .byNftCountAsc:
            sorted = viewModels.sorted { $0.nftCount < $1.nftCount }
        case .byNftCountDesc:
            sorted = viewModels.sorted { $0.nftCount > $1.nftCount }
        }
        return Just(sorted)
    }

    func navigateToCollectionWith(id: String) {
        navigation?.goToCollectionWith(id: id)
    }
}
