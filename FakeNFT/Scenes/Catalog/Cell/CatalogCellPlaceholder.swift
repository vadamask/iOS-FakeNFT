//
//  CatalogCellPlaceholder.swift
//  FakeNFT
//
//  Created by Виктор on 21.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CatalogCellPlaceholder: UICollectionViewCell, ReuseIdentifying {
    private var animationLayers = Set<CALayer>()
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
        label.textColor = .clear
        label.text = "placeholder"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        coverImage.layoutIfNeeded()
        label.layoutIfNeeded()
        addLoadingAnimation()
    }

    private func setupViews() {
        stackView.addArrangedSubview(coverImage)
        stackView.addArrangedSubview(label)
        contentView.addSubview(stackView)
    }

    private func setupConstraints() {
        coverImage.snp.makeConstraints { make in
            make.height.equalTo(140)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addLoadingAnimation() {
        let coverImageGradient = makeGradient()
        coverImageGradient.frame = coverImage.bounds
        coverImage.layer.addSublayer(coverImageGradient)

        let labelGradient = makeGradient()
        labelGradient.frame = label.bounds
        labelGradient.cornerRadius = labelGradient.frame.height / 2
        label.layer.addSublayer(labelGradient)

        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.duration = 0.7
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
        gradientChangeAnimation.toValue = [0, 0.8, 1]
        gradientChangeAnimation.autoreverses = true
        coverImageGradient.add(gradientChangeAnimation, forKey: "locationsChange")
        labelGradient.add(gradientChangeAnimation, forKey: "locationsChange")
    }

    private func makeGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.locations = [0, 0.1, 0.3]
        gradient.colors = [
            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 0.2).cgColor,
            UIColor(red: 0.531, green: 0.533, blue: 0.553, alpha: 0.4).cgColor,
            UIColor(red: 0.431, green: 0.433, blue: 0.453, alpha: 0.2).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.masksToBounds = true
        return gradient
    }
}
