//
//  ProfileCell.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileAssetsCell: UITableViewCell, ReuseIdentifying {
    //MARK: - Layout elements
    // >
    var disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = .textPrimary
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: .bodyBold17)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // текст ячейки главного экрана профиля
    var assetLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // числовое значение ячейки главного профиля
    var assetValueLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAssets(label: String? = nil, value: String?) {
        if let label = label { assetLabel.text = label }
        if let value = value { assetValueLabel.text = value }
    }
    
    private func setupConstraint() {
            [assetLabel, assetValueLabel, disclosureIndicator].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
        
        NSLayoutConstraint.activate([
            // текст ячейки таблицы
            assetLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            assetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            // числовое значение ячейки таблицы
            assetValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            assetValueLabel.leadingAnchor.constraint(equalTo: assetLabel.trailingAnchor, constant: 8),
            // >
            disclosureIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
