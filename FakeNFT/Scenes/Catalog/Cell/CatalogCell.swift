//
//  CatalogTableViewCell.swift
//  FakeNFT
//
//  Created by Виктор on 04.11.2023.
//

import UIKit
import SnapKit

final class CatalogCell: UITableViewCell, ReuseIdentifying {
    var viewModel: CatalogCellViewModel? {
        didSet {
            image.image = viewModel?.image
            label.text = viewModel?.labelText
        }
    }

    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private let image = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
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

    func setupViews() {
        contentView.backgroundColor = .screenBackground
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        contentView.addSubview(stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 13, right: 16))
        }
        image.snp.makeConstraints { make in
            make.height.equalTo(140)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
    }
}
