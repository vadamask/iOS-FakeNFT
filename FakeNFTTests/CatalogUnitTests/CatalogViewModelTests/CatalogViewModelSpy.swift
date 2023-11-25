//
//  CatalogViewModelSpy.swift
//  FakeNFTTests
//
//  Created by Виктор on 24.11.2023.
//

@testable import FakeNFT
import Foundation
import Combine

final class CatalogViewModelSpy: CatalogViewModelProtocol {
    var subscriptions = Set<AnyCancellable>()
    var state = CurrentValueSubject<CatalogViewModelState, Never>(.initial)
    var cellViewModels: [CatalogCellViewModel] = []
    var service: NftService?

    init(service: NftService? = nil) {
        self.service = service
    }

    func loadCollections() {
        state.value = .loading
    }
    
    func refreshCollections() {
        state.value = .refreshing
    }

    func changeSorting(to sortingType: CatalogViewModelSortingType) {}
    
    func navigateToCollectionWith(id: String) {}
}
