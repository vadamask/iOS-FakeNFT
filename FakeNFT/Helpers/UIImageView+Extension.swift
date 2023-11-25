//
//  File.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 25.11.2023.
//

import UIKit
import Kingfisher
// загрузка изображения из сети + скругление углов картинки
extension UIImageView {
    func loadImage(urlString: String?, placeholder: UIImage?, radius: Int?) {
        guard let url = URL(string: urlString ?? "") else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.processor(RoundCornerImageProcessor(cornerRadius: CGFloat(radius ?? 0)))])
    }
}
