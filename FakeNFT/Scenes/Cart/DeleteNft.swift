//
//  DeleteNftScreen.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 20.11.2023.
//

import UIKit

final class DeleteNft: UIViewController {
    var coordinator: CartCoordinator?
    
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterial)
        let view = UIVisualEffectView(effect: effect)
        view.frame = self.view.bounds
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.approveDeleteNft.image
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.text = L10n.Cart.DeleteScreen.approveDelete
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var approveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            L10n.Cart.DeleteScreen.delete,
            for: .normal
        )
        button.titleLabel?.font = .bodyRegular17
        button.setTitleColor(.yaRed, for: .normal)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = 12
        button.addTarget(
            self,
            action: #selector(approveButtonDidTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            L10n.Cart.DeleteScreen.goBack,
            for: .normal
        )
        button.titleLabel?.font = .bodyRegular17
        button.setTitleColor(.textPrimaryInvert, for: .normal)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = 12
        button.addTarget(
            self,
            action: #selector(returnButtonDidTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    @objc private func approveButtonDidTapped() {
        coordinator?.dismiss(isApproved: true)
    }
    
    @objc private func returnButtonDidTapped() {
        coordinator?.dismiss(isApproved: false)
    }
    
    private func setupLayout() {
        view.addSubview(blurView)
        blurView.contentView.addSubview(imageView)
        blurView.contentView.addSubview(label)
        blurView.contentView.addSubview(approveButton)
        blurView.contentView.addSubview(returnButton)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 108, height: 108))
            make.top.equalTo(244)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.equalTo(97)
            make.trailing.equalTo(-97)
        }
        
        approveButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.equalTo(56)
            make.height.equalTo(44)
            make.width.equalTo(returnButton)
        }
        
        returnButton.snp.makeConstraints { make in
            make.top.height.equalTo(approveButton)
            make.trailing.equalTo(-57)
            make.leading.equalTo(approveButton.snp.trailing).offset(8)
        }
    }
}
