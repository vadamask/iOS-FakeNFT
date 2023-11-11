//
//  PaymentViewModel.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 10.11.2023.
//
import Combine
import Foundation

enum OrderErrors: Error {
    case insufficientFunds
}

final class PaymentDetailsViewModel {
    @Published var isLoading: Bool?
    @Published var error: Error?
    @Published var selectedCurrencyID: String?
    
    var currencies = CurrentValueSubject<[Currency], Never>([])
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
    
    func verifyPayment() {
        guard let selectedCurrencyID else { return }
        isLoading = true
        
        serviceAssembly.nftService.verifyPayment(with: selectedCurrencyID) { [weak self] result in
            switch result {
            case .success(let orderPayment):
                if orderPayment.success {
                    print("payment successful")
                } else {
                    self?.error = OrderErrors.insufficientFunds
                }
            case .failure(let error):
                self?.error = error
            }
            self?.isLoading = false
        }
    }
    
    func currencyDidTapped(at indexPath: IndexPath) {
        selectedCurrencyID = currencies.value[indexPath.row].id
    }
}
