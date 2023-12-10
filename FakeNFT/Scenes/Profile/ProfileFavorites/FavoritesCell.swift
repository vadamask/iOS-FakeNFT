//
//  FavoritesCell.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 20.11.2023.
//

import UIKit

final class FavoritesCell: UICollectionViewCell, ReuseIdentifying {
    var tapAction: (() -> Void)?

    private lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var nftStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.backgroundColor = .screenBackground
        return stackView
    }()

    private lazy var nftName: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .textPrimary
        return label
    }()

    private lazy var nftRating: StarRatingController = {
        let starRating = StarRatingController(starsRating: 5)
        starRating.spacing = 2
        return starRating
    }()

    private lazy var nftPriceValue: UILabel = {
        let label = UILabel()
        label.font = .bodyRegular15
        label.textColor = .textPrimary
        label.text = "0 ETH"
        return label
    }()

    private lazy var nftFavorite: FavoriteButton = {
        let favoriteButton = FavoriteButton()
        favoriteButton.addTarget(self, action: #selector(self.didTapFavoriteButton(sender:)), for: .touchUpInside)
        return favoriteButton
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with model: Model) {
        nftImage.kf.setImage(with: URL(string: model.image))
        nftName.text = model.name
        nftRating.setStarsRating(rating: model.rating)
        nftPriceValue.text = "\(model.price) ETH"
        nftFavorite.isFavorite = model.isFavorite
        nftFavorite.nftID = model.id
    }

    @objc private func didTapFavoriteButton(sender: FavoriteButton) {
        sender.isFavorite.toggle()
        if let tapAction = tapAction { tapAction() }
    }

    private func setupConstraints() {
        [nftImage, nftFavorite, nftStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        [nftName, nftRating, nftPriceValue].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            nftStack.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            nftImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            nftImage.heightAnchor.constraint(equalToConstant: 80),
            nftImage.widthAnchor.constraint(equalToConstant: 80),

            nftFavorite.topAnchor.constraint(equalTo: nftImage.topAnchor, constant: -6),
            nftFavorite.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 6),
            nftFavorite.heightAnchor.constraint(equalToConstant: 42),
            nftFavorite.widthAnchor.constraint(equalToConstant: 42),

            nftStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftStack.leadingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 12),

            nftRating.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}

extension FavoritesCell {
    struct Model {
        let image: String
        let name: String
        let rating: Int
        let price: Double
        let isFavorite: Bool
        let id: String
    }
}
