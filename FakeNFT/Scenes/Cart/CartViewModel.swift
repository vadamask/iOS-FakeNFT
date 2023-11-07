//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 05.11.2023.
//
import Combine
import Foundation

final class CartViewModel {
    @Published var nfts: [Nft] = []
    @Published var error: Error?
    @Published var emptyState: Bool?
    
    private let servicesAssembly: ServicesAssembly
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func loadOrder() {
        servicesAssembly.nftService.loadOrder(id: "1") { [weak self] result in
            switch result {
            case .success(let order):
                if order.nfts.isEmpty {
                    self?.emptyState = true
                } else {
                    self?.emptyState = false
                    self?.loadNfts(order.nfts)
                }
            case .failure(let error):
                self?.error = error
            }
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
            self?.nfts = nfts
        }
    }
}
