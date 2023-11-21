//
//  HaveGradient.swift
//  FakeNFT
//
//  Created by Виктор on 18.11.2023.
//

import UIKit

// MARK: Use it in viewDidLoad (before, after or between "addSubView")
protocol HaveGradient {
    func applyGradient()
}

extension HaveGradient where Self: UIViewController {
    func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.clear,
            UIColor.yaBlack.withAlphaComponent(0.5)
        ].map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        view.layer.addSublayer(gradientLayer)
    }
}
