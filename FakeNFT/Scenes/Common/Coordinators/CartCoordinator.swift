//
//  CartCoordinator.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 17.11.2023.
//

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
        let cartController = CartViewController(viewModel: cartViewModel)
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
        let controller = DeleteNft()
        controller.modalPresentationStyle = .overFullScreen
        controller.coordinator = self
        navigationController.present(controller, animated: true)
    }
    
    func dismiss(isApproved: Bool) {
        if isApproved {
            onResponse?()
        }
        navigationController.dismiss(animated: true)
    }
}
