//
//  SuccessfulPayment.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 11.11.2023.
//
import SnapKit
import UIKit

final class SuccessfulPayment: UIViewController {
    var coordinator: CartCoordinator?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.successfulPayment.image
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .headline22
        label.textColor = .textPrimary
        label.text = L10n.Cart.SuccessfulPayment.label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let buton = ActionButton(
        title: L10n.Cart.SuccessfulPayment.backToCatatlog,
        type: .primary
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .screenBackground
        buton.action = { [weak self] _ in
            self?.coordinator?.goToCatatlogTab()
        }
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(buton)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 278, height: 278))
            make.centerX.equalToSuperview()
            make.top.equalTo(196)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(36)
            make.trailing.equalTo(-36)
        }
        
        buton.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(60)
        }
    }
}
