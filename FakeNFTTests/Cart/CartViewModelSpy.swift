//
//  CartViewModelStub.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//
@testable import FakeNFT
import Foundation

final class CartViewModelSpy: CartViewModelProtocol {
    @Published var nfts: [Nft] = []
    var nftsPublished: Published<[Nft]> { _nfts }
    var nftsPublisher: Published<[Nft]>.Publisher { $nfts }
    
    @Published var error: Error?
    var errorPublished: Published<Error?> { _error }
    var errorPublisher: Published<Error?>.Publisher { $error }
    
    @Published var emptyState: Bool?
    var emptyStatePublished: Published<Bool?> { _emptyState }
    var emptyStatePublisher: Published<Bool?>.Publisher { $emptyState }
    
    @Published var isLoading: Bool?
    var isLoadingPublished: Published<Bool?> { _isLoading }
    var isLoadingPublisher: Published<Bool?>.Publisher { $isLoading }
    
    let servicesAssembly: ServicesAssemblyProtocol
    var loadOrderCalled = false
    var paymentDidTappedCalled = false
    
    private var coordinator: CartCoordinator
    
    init(servicesAssembly: ServicesAssemblyProtocol, coordinator: CartCoordinator) {
        self.servicesAssembly = servicesAssembly
        self.coordinator = coordinator
    }
    
    func loadOrder() {
        loadOrderCalled = true
    }
    
    func paymentDidTapped() {
        paymentDidTappedCalled = true
    }
    
    func setSortOption(_ option: SortOption) {}
    
    func didRefreshTableView() {}
    
    func deleteButtonTapped(with id: String) {}
}
