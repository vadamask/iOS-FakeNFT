//
//  PaymentViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 10.11.2023.
//

import Foundation

final class PaymentDetailsViewModel {
    @Published var currencies: [Currency] = []
    @Published var isLoading: Bool?
    @Published var error: Error?
    private let serviceAssembly: ServicesAssembly
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func loadCurrencies() {
        serviceAssembly.nftService.loadCurrencies { result in
            switch result {
            case .success(let currencies):
                self.currencies = currencies
            case .failure(let error):
                self.error = error
            }
        }
    }
}
