//
//  OnboardingPage.swift
//  FakeNFT
//
//  Created by Виктор on 18.11.2023.
//

import UIKit

final class OnboardingPage: UIViewController, HaveGradient {
    private let bgImage: UIImage
    private let pageTitle: String
    private let pageDescription: String
    private let button: ActionButton?

    private lazy var titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .headline32
        label.text = self.pageTitle
        return label
    }()

    private lazy var descriptionLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bodyRegular15
        label.text = self.pageDescription
        label.numberOfLines = 5
        return label
    }()

    private lazy var bgImageView = {
        let imageView = UIImageView(image: self.bgImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var stackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.titleLabel,
                self.descriptionLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    init(bgImage: UIImage, title: String, description: String, button: ActionButton? = nil) {
        self.bgImage = bgImage
        self.pageTitle = title
        self.pageDescription = description
        self.button = button
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImageView)
        applyGradient()
        view.addSubview(stackView)
        view.addSubview(stackView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-140)
        }

        if let button = button {
            view.addSubview(button)
            button.snp.makeConstraints { make in
                make.width.equalTo(stackView)
                make.height.equalTo(60)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
            }
        }
    }
}
