//
//  CatalogTableViewCell.swift
//  FakeNFT
//
//  Created by Виктор on 04.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CatalogCell: UITableViewCell, ReuseIdentifying {
    var viewModel: CatalogCellViewModel? {
        didSet {
            update()
        }
    }

    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private let coverImage = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let label = {
        let label = UILabel()
        label.font = .headline17
        label.textColor = .textPrimary
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        coverImage.image = nil
    }

    private func setupViews() {
        contentView.backgroundColor = .screenBackground
        stackView.addArrangedSubview(coverImage)
        stackView.addArrangedSubview(label)
        contentView.addSubview(stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 13, right: 16))
        }
        coverImage.snp.makeConstraints { make in
            make.height.equalTo(140)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
    }

    private func update() {
        guard let viewModel else { return }
        label.text = "\(viewModel.name) (\(viewModel.nftCount))"
        coverImage.kf.setImage(with: viewModel.coverUrl)
    }
}
