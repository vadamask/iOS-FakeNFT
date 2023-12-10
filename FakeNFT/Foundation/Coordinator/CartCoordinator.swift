//
//  CartCoordinator.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 17.11.2023.
//
import SafariServices
import UIKit

final class CartCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var onResponse: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cartViewModel = CartViewModel(
            servicesAssembly: ServicesAssembly.shared,
            coordinator: self
        )
        let cartView = CartView()
        let cartController = CartViewController(
            viewModel: cartViewModel,
            cartView: cartView
        )
        navigationController.pushViewController(cartController, animated: true)
    }
    
    func goToPaymentDetails() {
        let viewModel = PaymentDetailsViewModel(
            serviceAssembly: ServicesAssembly.shared,
            coordinator: self
        )
        let controller = PaymentDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func pop() {
        let controller = parentCoordinator?
            .navigationController
            .viewControllers.first as? TabBarController
        controller?.tabBar.isHidden = false
        navigationController.popViewController(animated: true)
    }
    
    func goToSuccessPayment() {
        let controller = SuccessfulPayment()
        controller.modalPresentationStyle = .overFullScreen
        controller.coordinator = self
        navigationController.present(controller, animated: true)
    }
    
    func goToCatatlogTab() {
        let controller = parentCoordinator?
            .navigationController
            .viewControllers.first as? TabBarController
        controller?.selectedIndex = 1
        controller?.tabBar.isHidden = false
        navigationController.popToRootViewController(animated: false)
        navigationController.dismiss(animated: true)
    }
    
    func goToDeleteNft() {
        let controller = DeleteNftViewController()
        controller.modalPresentationStyle = .overFullScreen
        controller.coordinator = self
        navigationController.present(controller, animated: true)
    }
    
    func goToTerms() {
        let termsURL = "https://yandex.ru/legal/practicum_termsofuse/"
        guard let url = URL(string: termsURL) else { return }
        let controller = SFSafariViewController(url: url)
        controller.modalPresentationStyle = .pageSheet
        navigationController.present(controller, animated: true)
    }
    
    func dismiss(isApproved: Bool) {
        if isApproved {
            onResponse?()
        }
        navigationController.dismiss(animated: true)
    }
}
