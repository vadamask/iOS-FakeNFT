//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 05.11.2023.
//
import Combine
import Foundation

enum SortOption: Int {
    case name
    case price
    case rating
}

private enum Constants {
    static let sortCartKey = "sortCartKey"
}

final class CartViewModel {
    @Published var nfts: [Nft] = []
    @Published var error: Error?
    @Published var emptyState: Bool?
    @Published var isLoading: Bool?
    
    private var sortOption = SortOption.name
    private let servicesAssembly: ServicesAssembly
    private let userDefaults = UserDefaults.standard
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        getSortOption()
    }
    
    func setSortOption(_ option: SortOption) {
        sortOption = option
        userDefaults.set(option.rawValue, forKey: Constants.sortCartKey)
        nfts = sort(nfts)
    }
    
    func loadOrder() {
        isLoading = true
        
        servicesAssembly.nftService.loadOrder(id: "1") { [weak self] result in
            switch result {
            case .success(let order):
                if order.nfts.isEmpty {
                    self?.emptyState = true
                    self?.isLoading = false
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
                        nfts.append(nft)
                    case .failure(let error):
                        self?.error = error
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            self.nfts = sort(nfts)
        }
    }
    
    private func getSortOption() {
        let rawValue = userDefaults.integer(forKey: Constants.sortCartKey)
        if let sortOption = SortOption(rawValue: rawValue) {
            self.sortOption = sortOption
        }
    }
}
