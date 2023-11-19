//
//  BottomView.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 09.11.2023.
//

import UIKit

final class BottomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .placeholderBackground
        layer.cornerRadius = 12
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
