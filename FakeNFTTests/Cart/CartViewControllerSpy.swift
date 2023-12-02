//
//  CartViewControllerSpy.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//
@testable import FakeNFT
import Foundation

final class CartViewControllerSpy: CartViewControllerProtocol {
    var cartView: CartViewProtocol
    
    var viewModel: CartViewModelProtocol
    
    init(viewModel: CartViewModelProtocol, cartView: CartViewProtocol) {
        self.viewModel = viewModel
        self.cartView = cartView
    }
    
    func viewDidLoad() {}
    
    func viewDidAppear(_ animated: Bool) {
        viewModel.loadOrder()
    }
}
