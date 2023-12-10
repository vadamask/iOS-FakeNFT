//
//  CartTests.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//

@testable import FakeNFT
import XCTest

final class CartTests: XCTestCase {
    func testCartViewControllerCallsLoadOrder() {
        // given
        let services = ServicesAssemblyStub()
        let viewModel = CartViewModelSpy(
            servicesAssembly: services,
            coordinator: CartCoordinator(navigationController: UINavigationController())
        )
        let controller: CartViewControllerProtocol = CartViewController(
            viewModel: viewModel,
            cartView: CartView()
        )
        
        // when
        controller.viewDidAppear(false)
        
        // then
        XCTAssertTrue(viewModel.loadOrderCalled)
    }
    
    func testViewCallsPaymentDidTapped() {
        // given
        let services = ServicesAssemblyStub()
        let viewModel = CartViewModelSpy(
            servicesAssembly: services,
            coordinator: CartCoordinator(navigationController: UINavigationController())
        )
        let cartView = CartViewSpy()
        let controller: CartViewControllerProtocol = CartViewController(
            viewModel: viewModel,
            cartView: cartView
        )
        
        // when
        controller.viewDidLoad()
        cartView.onResponse?()
        
        // then
        XCTAssertTrue(viewModel.paymentDidTappedCalled)
    }
    
    func testLoadingOrder() {
        // given
        let services = ServicesAssemblyStub()
        let viewModel = CartViewModel(
            servicesAssembly: services,
            coordinator: CartCoordinator(navigationController: UINavigationController())
        )
        let controller: CartViewControllerProtocol = CartViewController(
            viewModel: viewModel,
            cartView: CartView()
        )
        
        // when
        controller.viewDidAppear(false)
        
        // then
        let exp = expectation(description: "after 3 seconds")
        _ = XCTWaiter.wait(for: [exp], timeout: 3)
        XCTAssertEqual(viewModel.nfts.count, 3)
    }
}
