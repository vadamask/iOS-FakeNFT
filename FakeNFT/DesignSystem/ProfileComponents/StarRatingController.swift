//
//  StarRating.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 19.11.2023.
//

import UIKit
// установка и обновление кол-ва звёзд в рейтинге в зависимости от оценки
final class StarRatingController: UIStackView {
    private var starsRating = 0
    private var starsEmptyPicName = "ratingInactive"
    private var starsFilledPicName = "ratingActive"
    
    init(starsRating: Int = 0) {
        super.init(frame: .zero)
        
        self.starsRating = starsRating
        
        var starTag = 1
        for _ in 0..<starsRating {
            let image = UIImageView()
            image.image = UIImage(asset: Asset.ratingInactive)
            image.tag = starTag
            self.addArrangedSubview(image)
            starTag += 1
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStarsRating(rating: Int) {
        self.starsRating = rating
        let stackSubViews = self.subviews
        for subView in stackSubViews {
            if let image = subView as? UIImageView {
                if image.tag > starsRating {
                    image.image = UIImage(asset: Asset.ratingInactive)
                } else {
                    image.image = UIImage(asset: Asset.ratingActive)
                }
            }
        }
    }
}
