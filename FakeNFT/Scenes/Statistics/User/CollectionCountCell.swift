//
//  CollectionCountCell.swift
//  FakeNFT
//
//  Created by Artem Adiev on 09.11.2023.
//

import UIKit
import SnapKit

final class CollectionCountCell: UITableViewCell, ReuseIdentifying {
    // MARK: - UI elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold17
        label.textColor = .textPrimary
        label.text = L10n.User.nftCollection
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold17
        label.textColor = .textPrimary
        return label
    }()

    let customDisclosureIndicator: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .segmentActive
        return imageView
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .screenBackground
        accessoryView = customDisclosureIndicator
        contentView.backgroundColor = .screenBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(16) // = make.top.equalToSuperview().offset(16)
            make.leading.equalTo(16)
            make.centerY.equalTo(contentView) // = make.centerY.equalTo(contentView.snp.centerY)
        }

        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }

    // MARK: - Configure Cell
    func set(count: Int) {
        countLabel.text = "(\(count))"
    }
}
