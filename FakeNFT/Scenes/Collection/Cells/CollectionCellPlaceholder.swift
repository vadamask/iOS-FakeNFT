//
//  CollectionCellPlaceholder.swift
//  FakeNFT
//
//  Created by Виктор on 22.11.2023.
//

import UIKit

final class CollectionCellPlaceholder: UICollectionViewCell, ReuseIdentifying {
    private let topView = {
        let view = UIView()
        return view
    }()

    private let bottomView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        topView.layoutIfNeeded()
        bottomView.layoutIfNeeded()
        addLoadingAnimation()
    }

    private func setupView() {
        contentView.addSubview(topView)
        contentView.addSubview(bottomView)
    }

    private func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(8)
            make.width.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func addLoadingAnimation() {
        let topGradient = makeGradient()
        topGradient.frame = topView.bounds
        topGradient.cornerRadius = 12
        topView.layer.addSublayer(topGradient)

        let bottomGradient = makeGradient()
        bottomGradient.frame = bottomView.bounds
        bottomGradient.cornerRadius = 12
        bottomView.layer.addSublayer(bottomGradient)

        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.duration = 0.7
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
        gradientChangeAnimation.toValue = [0, 0.8, 1]
        gradientChangeAnimation.autoreverses = true
        topGradient.add(gradientChangeAnimation, forKey: "locationsChange")
        bottomGradient.add(gradientChangeAnimation, forKey: "locationsChange")
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
