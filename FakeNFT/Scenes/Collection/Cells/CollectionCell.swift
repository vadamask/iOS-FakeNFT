//
//  CollectionViewCell.swift
//  FakeNFT
//
//  Created by Виктор on 10.11.2023.
//

import UIKit
import Combine
import SnapKit

final class CollectionCell: UICollectionViewCell, ReuseIdentifying {
    var viewModel: CollectionCellViewModel? {
        didSet {
            updateView()
        }
    }

    var subscriptions: Set<AnyCancellable> = []
    private(set) var likeAction = PassthroughSubject<(String, Bool), Never>()
    private(set) var cartAction = PassthroughSubject<(String, Bool), Never>()

    private let imageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var likeButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var addToCartButton = {
        let button = UIButton(type: .system)
        button.tintColor = .segmentActive
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()

    private let nameLabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .headline17
        return label
    }()

    private let ratingStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        return stackView
    }()

    private let priceLabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()

    private let mainStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let infoStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private let namePriceStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private let bottomStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        subscriptions.removeAll()
        nameLabel.text = nil
        priceLabel.text = nil
        imageView.image = nil
        for view in ratingStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }

    private func setupView() {
        imageView.addSubview(likeButton)
        namePriceStackView.addArrangedSubview(nameLabel)
        namePriceStackView.addArrangedSubview(priceLabel)
        bottomStackView.addArrangedSubview(namePriceStackView)
        bottomStackView.addArrangedSubview(addToCartButton)
        infoStackView.addArrangedSubview(ratingStackView)
        infoStackView.addArrangedSubview(bottomStackView)
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(infoStackView)
        contentView.addSubview(mainStackView)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.width)
        }
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(likeButton.snp.width)
        }
        addToCartButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(addToCartButton.snp.width)
        }
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        priceLabel.text = "\(viewModel.price) ETH"
        addToCartButton.setImage(viewModel.inOrder ? Asset.deleteCartButton.image : Asset.addCartButton.image, for: .normal)
        likeButton.setImage(viewModel.isLiked ? Asset.liked.image : Asset.notLiked.image, for: .normal)
        imageView.kf.setImage(with: viewModel.imageUrls[0])
        for i in 1...5 {
            if i <= viewModel.rating {
                let ratingImage = UIImageView(image: Asset.ratingActive.image)
                ratingStackView.addArrangedSubview(ratingImage)
            } else {
                let ratingImage = UIImageView(image: Asset.ratingInactive.image)
                ratingStackView.addArrangedSubview(ratingImage)
            }
        }
        let spacer = UIView()
        ratingStackView.addArrangedSubview(spacer)
    }

    @objc private func likeButtonTapped() {
        guard
            let id = viewModel?.id,
            let isLiked = viewModel?.isLiked else { return }
        likeAction.send((id, !isLiked))
    }

    @objc private func cartButtonTapped() {
        guard
            let id = viewModel?.id,
            let inOrder = viewModel?.inOrder else { return }
        cartAction.send((id, !inOrder))
    }
}
