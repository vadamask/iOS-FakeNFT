//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import Foundation

enum CatalogViewState {
    case initial, loading, failed(Error), loaded
}

enum CatalogViewSortingType {
    case byName, byNftCount
}

final class CatalogViewModel {
    private let service: NftService
    private(set) var cellViewModels: [CatalogCellViewModel]?
    @Observable private(set) var state: CatalogViewState
    private var sortingType: CatalogViewSortingType

    init(service: NftService) {
        self.service = service
        state = .initial
        sortingType = .byName
    }

    func viewDidLoaded() {
        loadCollections()
    }

    private func loadCollections() {
        state = .loading
        service.loadNftCollections { [weak self] result in
            switch result {
            case .success(let nftCollections):
                self?.cellViewModels = self?.convertToCellViewModels(nftCollections)
                self?.state = .loaded
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }

    private func convertToCellViewModels(_ nftCollections: [NftCollection]) -> [CatalogCellViewModel] {
        return nftCollections.map { nftCollection in
            CatalogCellViewModel(
                name: nftCollection.name,
                coverUrl: nftCollection.cover,
                nftCount: nftCollection.nfts.count
            )
        }
    }
}
