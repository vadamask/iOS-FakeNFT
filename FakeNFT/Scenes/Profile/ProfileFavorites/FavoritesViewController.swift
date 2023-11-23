//
//  ProfileFavoritesViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 15.11.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    // кнопка назад
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.backButton.image,
            style: .plain,
            target: self,
            action: #selector(didTapBackButton))
        button.tintColor = .textPrimary
        return button
    }()
    // лейбл при отсутствии нфт
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.emptyFavouriteNFTLabel // У вас ещё нет избранных NFT
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubview()
        addEdgeSwipeBackGesture()
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
    
    func addSubview() {
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
