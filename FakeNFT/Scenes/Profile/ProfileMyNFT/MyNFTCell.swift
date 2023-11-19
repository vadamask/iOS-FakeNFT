//
//  MyNFTCell.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 19.11.2023.
//

import UIKit

final class MyNFTCell: UITableViewCell {
    // NFT картинка
    private lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // стаквью с нфт
    private lazy var nftStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // лейбл с названием нфт
    private lazy var nftName: UILabel = {
        let label = UILabel()
        label.font = .headline17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // рейтинг (5 звезд)
    private lazy var nftRating: StarRating = {
        let nftRating = StarRating(starsRating: 5)
        nftRating.translatesAutoresizingMaskIntoConstraints = false
        return nftRating
    }()
    // лейбл "автор нфт"
    private lazy var nftAuthor: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // стаквью нфт
    private lazy var nftPrice: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // лейбл "Цена"
    private lazy var nftPriceText: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        label.text = L10n.Profile.priceText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // цена нфт в ETH
    private lazy var nftPriceValue: UILabel = {
        let label = UILabel()
        label.font = .headline17
        label.textColor = .textPrimary
        label.text = "0 ETH"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // лайк на нфт
    private lazy var nftFavorite: FavoriteButton = {
        let button = FavoriteButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        contentView.addSubview(nftImage)
        contentView.addSubview(nftFavorite)
        contentView.addSubview(nftStack)
        nftStack.addArrangedSubview(nftName)
        nftStack.addArrangedSubview(nftRating)
        nftStack.addArrangedSubview(nftAuthor)
        contentView.addSubview(nftPrice)
        nftPrice.addArrangedSubview(nftPriceText)
        nftPrice.addArrangedSubview(nftPriceValue)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // картинка нфт
            nftImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nftImage.heightAnchor.constraint(equalToConstant: 108),
            nftImage.widthAnchor.constraint(equalToConstant: 108),
            
            // лайк
            nftFavorite.topAnchor.constraint(equalTo: nftImage.topAnchor),
            nftFavorite.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor),
            nftFavorite.heightAnchor.constraint(equalToConstant: 42),
            nftFavorite.widthAnchor.constraint(equalToConstant: 42),
            
            // стаквью с нфт (картинка, рейтинг, автор)
            nftStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 144),
            nftStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -88),
            nftRating.heightAnchor.constraint(equalToConstant: 12),
            
            // стаквью с нфт (цена)
            nftPrice.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftPrice.leadingAnchor.constraint(equalTo: nftStack.trailingAnchor)
        ])
    }
}

extension MyNFTCell: ReuseIdentifying {
}
