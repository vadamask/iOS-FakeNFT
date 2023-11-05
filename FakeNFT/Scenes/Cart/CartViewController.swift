//
//  ShoppingCartViewController.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 04.11.2023.
//

import SnapKit
import UIKit

final class CartViewController: UIViewController {
    private let cartView = CartView()
    private let viewModel: CartViewModel

    init(servicesAssembly: ServicesAssembly) {
        viewModel = CartViewModel(servicesAssembly: servicesAssembly)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = cartView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        
        let barButtonItem = UIBarButtonItem(
            image: Asset.sortButton.image,
            style: .plain,
            target: self,
            action: #selector(sortNFT)
        )
        barButtonItem.tintColor = .borderColor
        navigationItem.rightBarButtonItem = barButtonItem

        cartView.tableView.dataSource = self
    }

    @objc private func sortNFT() {}
}

extension CartViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.nft.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = cartView.tableView.dequeueReusableCell() as CartCell
        cell.setup(with: viewModel.nft[indexPath.row])
        return cell
    }
}
