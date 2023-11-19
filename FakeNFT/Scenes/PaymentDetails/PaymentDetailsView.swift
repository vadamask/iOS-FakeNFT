//
//  PaymentView.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 09.11.2023.
//
import SnapKit
import UIKit

protocol PaymentDetailsViewDelegate: AnyObject {
    func payButtonTapped()
}

final class PaymentDetailsView: UIView {
    weak var delegate: PaymentDetailsViewDelegate?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CurrencyCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        collectionView.backgroundColor = .screenBackground
        return collectionView
    }()

    lazy var payButton = ActionButton(
        title: L10n.Cart.PaymentScreen.payButton,
        type: .primary
    )
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        label.numberOfLines = 0
        label.text = L10n.Cart.PaymentScreen.terms
        return label
    }()
    
    private lazy var bottomView = BottomView()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .screenBackground
        payButton.action = { [weak self] _ in
            self?.payButtonTapped()
        }
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        addSubview(bottomView)
    
        bottomView.addSubview(payButton)
        bottomView.addSubview(linkLabel)
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(186)
        }
        
        payButton.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(60)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(10)
        }
    }
    
    @objc private func payButtonTapped() {
        delegate?.payButtonTapped()
    }
}
