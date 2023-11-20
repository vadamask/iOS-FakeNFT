//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 05.11.2023.
//

import Foundation

enum SortOption: Int {
    case name
    case price
    case rating
}

final class CartViewModel {
    @Published var nfts: [Nft] = []
    @Published var error: Error?
    @Published var emptyState: Bool?
    @Published var isLoading: Bool?
    let servicesAssembly: ServicesAssembly
    
    private var coordinator: CartCoordinator
    private var sortOption = SortOption.name
    private let userDefaults = UserDefaults.standard
    private let serialQueue = DispatchQueue(label: "loadNfts")
    
    init(servicesAssembly: ServicesAssembly, coordinator: CartCoordinator) {
        self.servicesAssembly = servicesAssembly
        self.coordinator = coordinator
        getSortOption()
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
        var ids = nfts.map { $0.id }
        servicesAssembly.nftService.deleteNft(id, from: ids) { [weak self] result in
            switch result {
            case .success(_):
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
}
