//
//  CurrencyCell.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 09.11.2023.
//
import Kingfisher
import SnapKit
import UIKit

final class CurrencyCell: UICollectionViewCell, ReuseIdentifying {
    static var defaultReuseIdentifier: String = "CurrencyCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.backgroundColor = .yaBlack
        return imageView
    }()
    
    private lazy var currencyName: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        return label
    }()
    
    private lazy var shortName: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .yaGreen
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Currency) {
        if let url = URL(string: model.image) {
            imageView.kf.setImage(with: url)
        }
        currencyName.text = model.title
        shortName.text = model.name
    }
    
    private func setupUI() {
        backgroundColor = .placeholderBackground
        layer.cornerRadius = 12
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(currencyName)
        contentView.addSubview(shortName)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        
        currencyName.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
        }
        
        shortName.snp.makeConstraints { make in
            make.leading.equalTo(currencyName)
            make.bottom.equalTo(-6)
        }
    }
}
