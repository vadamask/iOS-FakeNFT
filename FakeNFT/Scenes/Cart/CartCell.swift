//
//  CartCell.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 05.11.2023.
//

import UIKit

final class CartCell: UITableViewCell, ReuseIdentifying {
    static var defaultReuseIdentifier: String = "CartCell"
    private let nftImageView = UIImageView()
    private let deleteButton = UIButton(type: .system)
    private let nameLabel = UILabel()
    private let rating = UIStackView()
    private let priceName = UILabel()
    private let priceAndCurrency = UILabel()


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
        
        rating.arrangedSubviews.forEach {
            if let imageView = $0 as? UIImageView {
                imageView.image = Asset.ratingInactive.image
            }
        }
    }

    func setup(with model: Nft) {
        nftImageView.kf.setImage(with: model.images[0])
        nameLabel.text = model.name
        priceName.text = L10n.Cart.MainScreen.price
        priceAndCurrency.text = "\(model.price) ETH"

        for i in 0 ..< model.rating {
            if let imageView = rating.arrangedSubviews[i] as? UIImageView {
                imageView.image = Asset.ratingActive.image
            }
        }
    }

    private func setupUI() {
        contentView.backgroundColor = .screenBackground
        
        nftImageView.layer.cornerRadius = 12
        nftImageView.clipsToBounds = true
        nftImageView.contentMode = .scaleAspectFit
        
        deleteButton.setImage(
            Asset.deleteFromCartButton.image,
            for: .normal
        )
        deleteButton.tintColor = .borderColor

        nameLabel.font = .bodyBold17
        nameLabel.textColor = .textPrimary

        priceName.font = .caption13
        priceName.textColor = .textPrimary

        priceAndCurrency.font = .bodyBold17
        priceAndCurrency.textColor = .textPrimary

        rating.axis = .horizontal
        rating.spacing = 2
        rating.alignment = .center
        rating.distribution = .fillEqually
        for _ in 0..<5 {
            let imageView = UIImageView()
            imageView.image = Asset.ratingInactive.image
            rating.addArrangedSubview(imageView)
        }
    }

    private func setupLayout() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(rating)
        contentView.addSubview(priceName)
        contentView.addSubview(priceAndCurrency)
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

        rating.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }

        priceName.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(rating.snp.bottom).offset(12)
        }

        priceAndCurrency.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(priceName.snp.bottom).offset(2)
        }

        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
        }
    }
}
