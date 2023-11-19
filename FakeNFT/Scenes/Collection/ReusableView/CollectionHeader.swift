//
//  CollectionViewHeader.swift
//  FakeNFT
//
//  Created by Виктор on 10.11.2023.
//

import UIKit

final class CollectionHeader: UICollectionReusableView, ReuseIdentifying {
    var viewModel: CollectionHeaderViewModel? {
        didSet {
            updateUI()
        }
    }
    var onNameAuthorLabelClicked: ((URL) -> Void)?
    private let coverImageView = {
        let imageVIew = UIImageView()
        imageVIew.image = Asset.blueBonnie.image
        imageVIew.contentMode = .scaleAspectFill
        imageVIew.layer.cornerRadius = 12
        imageVIew.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageVIew.layer.masksToBounds = true
        imageVIew.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageVIew
    }()

    private let titleLabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .headline22
        return label
    }()

    private let authorLabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .caption13
        label.text = "Автор коллекции:"
        return label
    }()

    private lazy var nameAuthorLabel = {
        let label = UILabel()
        label.textColor = .tabActive
        label.font = .bodyRegular15
        label.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(authorLabelClicked))
        label.addGestureRecognizer(guestureRecognizer)
        return label
    }()

    private let descriptionLabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .caption13
        label.numberOfLines = 5
        return label
    }()

    private lazy var authorStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                authorLabel,
                nameAuthorLabel,
                UIView()
            ]
        )
        stackView.spacing = 4
        return stackView
    }()

    private lazy var titleAuthorStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                authorStackView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var textStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleAuthorStackView,
                descriptionLabel
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var mainStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                coverImageView,
                textStackView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func updateUI() {
        titleLabel.text = viewModel?.name
        nameAuthorLabel.text = viewModel?.author
        descriptionLabel.text = viewModel?.description
        coverImageView.kf.setImage(with: viewModel?.cover)
    }

    @objc private func authorLabelClicked() {
        guard let webSite = viewModel?.webSite else { return }
        onNameAuthorLabelClicked?(webSite)
    }
}
