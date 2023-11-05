//
//  RatingTableViewCell.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import UIKit
import SnapKit

struct User {
    let image: UIImage // String?
    let name: String
    let score: Int
}

final class RatingTableViewCell: UITableViewCell {
    private let contentContainer = UIView()
    private let numberLabel = UILabel()
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let scoreLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(contentContainer)
        contentView.addSubview(numberLabel)
        contentContainer.addSubview(userImageView)
        contentContainer.addSubview(nameLabel)
        contentContainer.addSubview(scoreLabel)

        contentView.backgroundColor = .clear

        contentContainer.backgroundColor = .placeholderBackground
        contentContainer.layer.cornerRadius = 8

        userImageView.layer.cornerRadius = 20
        userImageView.clipsToBounds = true

        numberLabel.font = UIFont.bodyRegular15
        nameLabel.font = UIFont.headline22
        scoreLabel.font = UIFont.headline22

        contentContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview()
        }

        numberLabel.snp.makeConstraints { make in
            make.right.equalTo(contentContainer.snp.left).offset(-16)
            make.centerY.equalToSuperview()
        }

        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(28)
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }

        scoreLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }

    func configure(with user: User, at index: Int) {
        numberLabel.text = "\(index)"
        userImageView.image = user.image
        nameLabel.text = user.name
        scoreLabel.text = "\(user.score)" // Преобразуем Int в String
    }
}
