//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import Foundation
import Combine

enum CatalogViewModelState {
    case loading, failed(Error), ready, sorting
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
    @Published private(set) var state: CatalogViewModelState = .loading
    var statePublisher: Published<CatalogViewModelState>.Publisher { $state }
    private(set) var cellViewModels: [CatalogCellViewModel]?
    private let service: NftService
    private let userDefaults = UserDefaults.standard
    private var sortingType: CatalogViewModelSortingType

    init(service: NftService) {
        self.service = service
        sortingType = userDefaults.sortingType
    }

    func loadCollections() {
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

    func changeSorting(to sortingType: CatalogViewModelSortingType) {
        self.sortingType = sortingType
        userDefaults.sortingType = self.sortingType
        sorting()
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
