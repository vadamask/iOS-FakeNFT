//
//  NoInternetView.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 19.11.2023.
//

import UIKit

final class NoInternetView: UIView {
    private lazy var noInternetLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.noInternet
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .screenBackground
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        addSubview(noInternetLabel)
        
        NSLayoutConstraint.activate([
            noInternetLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noInternetLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
