//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 05.11.2023.
//

import Foundation

protocol CartViewModelProtocol {
    var nfts: [Nft] { get }
    var nftsPublished: Published<[Nft]> { get }
    var nftsPublisher: Published<[Nft]>.Publisher { get }
    
    var error: Error? { get set }
    var errorPublished: Published<Error?> { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    
    var emptyState: Bool? { get set }
    var emptyStatePublished: Published<Bool?> { get }
    var emptyStatePublisher: Published<Bool?>.Publisher { get }
    
    var isLoading: Bool? { get set }
    var isLoadingPublished: Published<Bool?> { get }
    var isLoadingPublisher: Published<Bool?>.Publisher { get }
    
    func loadOrder()
    func paymentDidTapped()
    func setSortOption(_ option: SortOption)
    func didRefreshTableView()
    func deleteButtonTapped(with id: String)
}

enum SortOption: Int {
    case name
    case price
    case rating
}

final class CartViewModel: CartViewModelProtocol {
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
    
    private var coordinator: CartCoordinator
    private var sortOption = SortOption.name
    private let userDefaults = UserDefaults.standard
    private let serialQueue = DispatchQueue(label: "loadNfts")
    
    init(servicesAssembly: ServicesAssemblyProtocol, coordinator: CartCoordinator) {
        self.servicesAssembly = servicesAssembly
        self.coordinator = coordinator
        getSortOption()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(nftsDidDeleted),
            name: .nftsDeleted,
            object: nil
        )
    }
    
    func fakeRequest() {
        servicesAssembly.nftService.fakeRequest()
    }
    
    func paymentDidTapped() {
        coordinator.goToPaymentDetails()
    }
    
    func setSortOption(_ option: SortOption) {
        sortOption = option
        userDefaults.set(option.rawValue, forKey: UserDefaultsKeys.sortCartKey)
        nfts = sort(nfts)
    }
    
    func didRefreshTableView() {
        loadOrder(isPullToRefresh: true)
    }
    
    func loadOrder() {
        loadOrder(isPullToRefresh: false)
    }
    
    func deleteButtonTapped(with id: String) {
        coordinator.onResponse = { [weak self] in
            self?.deleteNft(with: id)
        }
        coordinator.goToDeleteNft()
    }
    
    func deleteNft(with id: String) {
        let ids = nfts.map { $0.id }
        servicesAssembly.nftService.deleteNft(id, from: ids) { [weak self] result in
            switch result {
            case .success:
                self?.loadOrder(isPullToRefresh: false)
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    private func loadOrder(isPullToRefresh: Bool) {
        isLoading = !isPullToRefresh
        
        servicesAssembly.nftService.loadOrder(id: "1") { [weak self] result in
            switch result {
            case .success(let order):
                if order.nfts.isEmpty {
                    self?.emptyState = true
                    self?.isLoading = false
                    self?.nfts = []
                } else {
                    self?.emptyState = false
                    self?.loadNfts(order.nfts)
                }
            case .failure(let error):
                self?.error = error
                self?.isLoading = false
            }
        }
    }
    
    private func sort(_ nfts: [Nft]) -> [Nft] {
        switch sortOption {
        case .name:
            return nfts.sorted { $0.name < $1.name }
        case .price:
            return nfts.sorted { $0.price < $1.price }
        case .rating:
            return nfts.sorted { $0.rating > $1.rating }
        }
    }
    
    private func loadNfts(_ ids: [String]) {
        let group = DispatchGroup()
        var nfts: [Nft] = []
        
        ids.forEach { id in
            group.enter()
            DispatchQueue.global().async(group: group) { [weak self] in
                self?.servicesAssembly.nftService.loadNft(id: id) { result in
                    switch result {
                    case .success(let nft):
                        self?.serialQueue.async {
                            nfts.append(nft)
                        }
                    case .failure(let error):
                        self?.error = error
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self else { return }
            isLoading = false
            self.nfts = sort(nfts)
        }
    }
    
    private func getSortOption() {
        let rawValue = userDefaults.integer(forKey: UserDefaultsKeys.sortCartKey)
        if let sortOption = SortOption(rawValue: rawValue) {
            self.sortOption = sortOption
        }
    }
    
    @objc private func nftsDidDeleted() {
        nfts = []
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
