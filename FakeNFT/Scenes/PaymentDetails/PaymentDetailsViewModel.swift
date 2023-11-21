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
    @Published var selectedCurrencyID: String?
    @Published var isPaymentSuccess: Bool?
    var currencies = CurrentValueSubject<[Currency], Never>([])
    
    private let servicesAssembly: ServicesAssembly
    private var coordinator: CartCoordinator
    
    init(serviceAssembly: ServicesAssembly, coordinator: CartCoordinator) {
        self.servicesAssembly = serviceAssembly
        self.coordinator = coordinator
    }
    
    func loadCurrencies() {
        isLoading = true
        servicesAssembly.nftService.loadCurrencies { [weak self] result in
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
        
        servicesAssembly.nftService.verifyPayment(with: selectedCurrencyID) { [weak self] result in
            switch result {
            case .success(let orderPayment):
                self?.isPaymentSuccess = orderPayment.success
                if orderPayment.success {
                    self?.deleteNfts()
                }
            case .failure(let error):
                self?.error = error
            }
            self?.isLoading = false
        }
    }
    
    func paymentDidTapped() {
        coordinator.goToSuccessPayment()
    }
    
    func currencyDidTapped(at indexPath: IndexPath) {
        selectedCurrencyID = currencies.value[indexPath.row].id
    }
    
    func backButtonDidTapped() {
        coordinator.pop()
    }
    
    func linkDidTapped() {
        coordinator.goToTerms()
    }
    
    private func deleteNfts() {
        let dto = NftDto(id: "1", nfts: [])
        servicesAssembly.nftService.clearOrder(dto) { [weak self] result in
            switch result {
            case .success:
                print("delete success")
            case .failure(let error):
                self?.error = error
            }
        }
    }
}
