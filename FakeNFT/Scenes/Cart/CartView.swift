//
//  ShoppingCartView.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 04.11.2023.
//

import SnapKit
import UIKit

final class CartView: UIView {
    var onResponse: (() -> Void)?
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyRegular15
        label.textColor = .textPrimary
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .yaGreen
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartCell.self)
        tableView.backgroundColor = .screenBackground
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Cart.MainScreen.emptyState
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.isHidden = true
        return label
    }()
    
    lazy var bottomView = BottomView()
    
    private let buyButton = ActionButton(
        title: L10n.Cart.MainScreen.buyNft,
        type: .primary
    )

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
        buyButton.action = { [weak self] _ in
            self?.onResponse?()
        }
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
