//
//  ProfileCell.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileCell: UITableViewCell {
    //MARK: - Layout elements
    // кнопка для открытия ячейки секции
    var openSection: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = .textPrimary // black
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: .bodyBold17)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // текст ячейки главного экрана профиля
    var textInSection: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .yaBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // числовое значение ячейки главного профиля
    var valueInSection: UILabel = {
        let label = UILabel()
        label.font = .bodyBold17
        label.textColor = .yaBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addTextInSection()
        addValueInSection()
        addOpenSection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTextInSection() {
        addSubview(textInSection)
        NSLayoutConstraint.activate([
            textInSection.centerYAnchor.constraint(equalTo: centerYAnchor),
            textInSection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    func addValueInSection() {
        addSubview(valueInSection)
        NSLayoutConstraint.activate([
            valueInSection.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueInSection.leadingAnchor.constraint(equalTo: textInSection.trailingAnchor, constant: 8)
        ])
    }
    
    func addOpenSection() {
        addSubview(openSection)
        NSLayoutConstraint.activate([
            openSection.centerYAnchor.constraint(equalTo: centerYAnchor),
            openSection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

extension ProfileCell: ReuseIdentifying {
    
}
