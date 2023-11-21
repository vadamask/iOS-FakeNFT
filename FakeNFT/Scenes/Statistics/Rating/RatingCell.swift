//
//  RatingTableViewCell.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import Kingfisher
import SnapKit
import UIKit

final class RatingCell: UITableViewCell, ReuseIdentifying {
    // MARK: - UI elements
    private let contentContainer: UIView = {
        let contentContainer = UIView()
        contentContainer.backgroundColor = .placeholderBackground
        contentContainer.layer.cornerRadius = 8
        return contentContainer
    }()

    private let numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.font = UIFont.bodyRegular15
        return numberLabel
    }()

    private let userImageView: UIImageView = {
        let userImageView = UIImageView()
        userImageView.layer.cornerRadius = 14
        userImageView.clipsToBounds = true
        return userImageView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.headline22
        return nameLabel
    }()

    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = UIFont.headline22
        return ratingLabel
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.addSubview(contentContainer)
        contentView.addSubview(numberLabel)
        contentContainer.addSubview(userImageView)
        contentContainer.addSubview(nameLabel)
        contentContainer.addSubview(ratingLabel)
    }

    private func setupConstraints() {
        contentContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview()
        }

        numberLabel.snp.makeConstraints { make in
            make.trailing.lessThanOrEqualTo(contentContainer.snp.leading).offset(-16)
            make.centerY.equalToSuperview()
        }

        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(28)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }

        ratingLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }

    // MARK: - Configure Cell
    func configure(with user: User, at index: Int) {
        numberLabel.text = "\(index)"
        nameLabel.text = user.name
        ratingLabel.text = user.rating
        userImageView.kf.setImage(with: user.avatar)
    }
}
