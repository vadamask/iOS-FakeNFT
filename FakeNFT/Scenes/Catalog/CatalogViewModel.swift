//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import Foundation

enum CatalogViewState {
    case initial, loading, failed(Error), ready, sorting
}

enum CatalogViewSortingType: Int {
    case byNameAsc, byNameDesc, byNftCountAsc, byNftCountDesc
}

protocol CatalogViewModelProtocol {
    var state: CatalogViewState { get }
    var publishedState: Observable<CatalogViewState> { get }
    var cellViewModels: [CatalogCellViewModel]? { get }
    func viewDidLoaded()
    func changeSorting(to sortingType: CatalogViewSortingType)
}

final class CatalogViewModel: CatalogViewModelProtocol {
    @Observable private(set) var state: CatalogViewState
    var publishedState: Observable<CatalogViewState> { $state }
    private(set) var cellViewModels: [CatalogCellViewModel]?
    private let service: NftService
    private let userDefaults = UserDefaults.standard
    private var sortingType: CatalogViewSortingType

    init(service: NftService) {
        self.service = service
        state = .initial
        sortingType = userDefaults.sortingType
    }

    func viewDidLoaded() {
        loadCollections()
    }

    func changeSorting(to sortingType: CatalogViewSortingType) {
        self.sortingType = sortingType
        userDefaults.sortingType = self.sortingType
        sorting()
    }

    private func loadCollections() {
        state = .loading
        service.loadNftCollections { [weak self] result in
            switch result {
            case .success(let nftCollections):
                self?.convertToCellViewModels(nftCollections)
                self?.sorting()
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }

    private func convertToCellViewModels(_ nftCollections: [NftCollection]) {
        cellViewModels = nftCollections.map { nftCollection in
            CatalogCellViewModel(
                name: nftCollection.name,
                coverUrl: nftCollection.cover,
                nftCount: nftCollection.nfts.count
            )
        }
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
}
