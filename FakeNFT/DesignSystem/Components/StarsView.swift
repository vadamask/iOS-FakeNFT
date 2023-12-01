//
//  StarsView.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 21.11.2023.
//

import UIKit
// вью для звездного рейтинга нфт
final class StarsView: UIView {
    enum Rating: Int {
        case zero
        case one
        case two
        case three
        case four
        case five
    }
    var rating: Rating = .zero {
        didSet {
            self.setRating(self.rating)
        }
    }
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let stars: [UIImageView] = {
        var stars: [UIImageView] = []
        for i in 0..<5 {
            let star = UIImage(named: "ratingInactive")
            let starImageView = UIImageView(image: star)
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.tintColor = .yaGray
            starImageView.contentMode = .scaleAspectFit
            stars.append(starImageView)
        }
        return stars
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension StarsView {
    func configure() {
        self.addSubviews()
        self.addConstraints()
    }
    func addSubviews() {
        self.addSubview(self.stackView)
        self.stars.forEach { self.stackView.addArrangedSubview($0) }
    }
    func addConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
private extension StarsView {
    func setRating(_ rating: Rating) {
        let rating = rating.rawValue
        for i in 0..<rating {
            let star = self.stars[i]
            star.tintColor = .yaYellow
        }
    }
}
