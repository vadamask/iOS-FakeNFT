//
//  ProfileMyNFTViewController.swift
//  FakeNFT
//
//  Created by Anka on 15.11.2023.
//

import UIKit

final class ProfileMyNFTViewController: UIViewController {
    // кнопка назад
    private lazy var backButton = UIBarButtonItem(
        image: Asset.backButton.image,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    // лейбл при отсутствии нфт
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.emptyNFTLabel // У вас ещё нет NFT
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addEmptyLabel()
    }
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .screenBackground
    }
    
    func addEmptyLabel() {
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}
