//
//  PaymentViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 10.11.2023.
//
import Combine
import Foundation

final class PaymentDetailsViewModel {
    @Published var isLoading: Bool?
    @Published var error: Error?
    var currencies = CurrentValueSubject<[Currency], Never>([])
    var selectedCurrency: Int?
    private let serviceAssembly: ServicesAssembly
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func loadCurrencies() {
        isLoading = true
        serviceAssembly.nftService.loadCurrencies { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies.send(currencies)
            case .failure(let error):
                self?.error = error
            }
            self?.isLoading = false
        }
    }
}
