//
//  ShoppingCartView.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 04.11.2023.
//

import SnapKit
import UIKit

final class CartView: UIView {
    let countLabel = UILabel()
    let priceLabel = UILabel()
    let tableView = UITableView()
    let emptyStateLabel = UILabel()
    let bottomView = UIView()
    
    private let buyButton = ActionButton(title: L10n.Cart.buyNFT, type: .primary)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .screenBackground
        bottomView.backgroundColor = .placeholderBackground
        bottomView.layer.cornerRadius = 12
        bottomView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]

        countLabel.font = .bodyRegular15
        priceLabel.font = .bodyBold17
        countLabel.textColor = .textPrimary
        priceLabel.textColor = .yaGreen
        
        tableView.register(CartCell.self)
        tableView.backgroundColor = .screenBackground
        tableView.separatorStyle = .none
        
        emptyStateLabel.text = L10n.Cart.emptyState
        emptyStateLabel.font = .bodyBold17
        emptyStateLabel.textColor = .textPrimary
        emptyStateLabel.isHidden = true
    }

    private func setupLayout() {
        addSubview(bottomView)
        addSubview(tableView)
        addSubview(emptyStateLabel)
        bottomView.addSubview(countLabel)
        bottomView.addSubview(priceLabel)
        bottomView.addSubview(buyButton)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(bottomView.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(76)
        }

        countLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
        }

        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(countLabel)
            make.bottom.equalTo(-16)
        }

        buyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
            make.size.equalTo(CGSize(width: 240, height: 44))
        }
        
        emptyStateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
