//
//  PaymentView.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 09.11.2023.
//
import SnapKit
import UIKit

final class PaymentView: UIView {
    private lazy var bottomView = BottomView()
    private lazy var payButton = ActionButton(
        title: L10n.Cart.PaymentScreen.payButton,
        type: .primary
    )
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(CurrencyCell.self)
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.backButton.image, for: .normal)
        button.tintColor = .borderColor
        return button
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.text = L10n.Cart.PaymentScreen.topBarTitle
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        label.numberOfLines = 0
        label.text = L10n.Cart.PaymentScreen.terms
        return label
    }()
    
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
    }
    
    private func setupLayout() {
        addSubview(bottomView)
        addSubview(backButton)
        addSubview(topLabel)
        bottomView.addSubview(payButton)
        bottomView.addSubview(linkLabel)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(9)
            make.top.equalTo(safeAreaLayoutGuide).offset(11)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.centerX.equalToSuperview()
        }
        
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
    }
}
