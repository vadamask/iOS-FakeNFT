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
            let image = self.isFavorite ? Asset.heartFilled.image : Asset.heartEmpty.image
            self.setImage(image, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
