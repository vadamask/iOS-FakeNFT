//
//  NoInternetView.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 19.11.2023.
//

import UIKit

final class NoContentView: UIView {
    private let noContent: NoContent
    private lazy var noContentLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.noInternet
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, noContent: NoContent) {
        self.noContent = noContent
        super.init(frame: .zero)
        self.backgroundColor = .screenBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(noContentLabel)
        
        NSLayoutConstraint.activate([
            noContentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noContentLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
