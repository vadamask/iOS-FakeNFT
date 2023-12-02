//
//  CartViewSpy.swift
//  FakeNFTTests
//
//  Created by Вадим Шишков on 23.11.2023.
//
@testable import FakeNFT
import UIKit

final class CartViewSpy: CartViewProtocol {
    var onResponse: (() -> Void)?
    
    var tableView = UITableView()
    var countLabel = UILabel()
    var priceLabel = UILabel()
    var bottomView = BottomView()
    var emptyStateLabel = UILabel()
}
