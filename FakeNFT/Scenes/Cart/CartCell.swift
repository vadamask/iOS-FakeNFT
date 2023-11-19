//
//  CartCell.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 05.11.2023.
//

import UIKit

final class CartCell: UITableViewCell, ReuseIdentifying {
    static var defaultReuseIdentifier: String = "CartCell"
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .borderColor
        button.setImage(
            Asset.deleteFromCartButton.image,
            for: .normal
        )
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .textPrimary
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        for _ in 0..<5 {
            let imageView = UIImageView()
            imageView.image = Asset.ratingInactive.image
            stackView.addArrangedSubview(imageView)
        }
        return stackView
    }()
    
    private lazy var priceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        return label
    }()
    
    private lazy var priceAndCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .textPrimary
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        ratingStackView.arrangedSubviews.forEach {
            if let imageView = $0 as? UIImageView {
                imageView.image = Asset.ratingInactive.image
            }
        }
    }

    func setup(with model: Nft) {
        nftImageView.kf.setImage(with: model.images[0])
        nameLabel.text = model.name
        priceNameLabel.text = L10n.Cart.MainScreen.price
        priceAndCurrencyLabel.text = "\(model.price) ETH"

        for i in 0 ..< model.rating {
            if let imageView = ratingStackView.arrangedSubviews[i] as? UIImageView {
                imageView.image = Asset.ratingActive.image
            }
        }
    }

    private func setupUI() {
        contentView.backgroundColor = .screenBackground
    }

    private func setupLayout() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingStackView)
        contentView.addSubview(priceNameLabel)
        contentView.addSubview(priceAndCurrencyLabel)
        contentView.addSubview(deleteButton)

        nftImageView.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
            make.bottom.equalTo(-16)
            make.size.equalTo(CGSize(width: 108, height: 108))
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nftImageView.snp.trailing).offset(20)
            make.top.equalTo(24)
        }

        ratingStackView.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }

        priceNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(ratingStackView.snp.bottom).offset(12)
        }

        priceAndCurrencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(priceNameLabel.snp.bottom).offset(2)
        }

        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
        }
    }
}
