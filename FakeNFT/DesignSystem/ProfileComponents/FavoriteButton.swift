//
//  FavoriteButton.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 19.11.2023.
//

import UIKit
// лайк или дизлайк
final class FavoriteButton: UIButton {
    var nftID: String?
    var isFavorite: Bool = false {
        didSet {
            let imageName = self.isFavorite ? "heartFilled" : "heartEmpty"
            self.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
