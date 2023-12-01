//
//  ProfileCell.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileAssetsCell: UITableViewCell, ReuseIdentifying {
    // текст ячейки главного экрана профиля
    private lazy var assetLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold17
        label.textColor = .textPrimary
        return label
    }()
    // числовое значение ячейки главного профиля
    private lazy var assetValue: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline17
        label.textColor = .textPrimary
        return label
    }()
    // >
    private lazy var disclosureIndicator: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = .buttonBackground
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 17))
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAssets(label: String?, value: String?) {
        if let label = label { assetLabel.text = label }
        if let value = value { assetValue.text = value }
    }
    
    private func setupConstraint() {
            [assetLabel, assetValue, disclosureIndicator].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
        
        NSLayoutConstraint.activate([
            // текст ячейки таблицы
            assetLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            assetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            // числовое значение ячейки таблицы
            assetValue.centerYAnchor.constraint(equalTo: centerYAnchor),
            assetValue.leadingAnchor.constraint(equalTo: assetLabel.trailingAnchor, constant: 8),
            // >
            disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
