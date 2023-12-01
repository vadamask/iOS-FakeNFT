//
//  ProfileFavoritesViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 15.11.2023.
//

import UIKit

final class FavoritesViewController: UIViewController, UIGestureRecognizerDelegate {
    private let likedIDs: [String]
    private var viewModel: FavoritesViewModelProtocol
    private var badConnection: Bool = false
    // кнопка назад
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.backButton.image,
            style: .plain,
            target: self,
            action: #selector(didTapBackButton))
        button.tintColor = .borderColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupView()
        addEdgeSwipeBackGesture()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = .screenBackground
    }
    
    init(likedIDs: [String]) {
        self.likedIDs = likedIDs
        self.viewModel = FavoritesViewModel(likedIDs: likedIDs)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if badConnection { viewModel.getLikedNFTs(likedIDs: likedIDs) }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: - Private Methods
    private func bind() {
        viewModel.onChange = { [weak self] in
            self?.badConnection = false
            guard let view = self?.view as? FavoritesView,
                  let nfts = self?.viewModel.likedNFTs else { return }
            view.updateNFT(nfts: nfts)
        }
        
        viewModel.onError = { [weak self] error in
            self?.badConnection = true
            let alert = UIAlertController(
                title: L10n.Profile.noInternet,
                message: error.localizedDescription,
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Layout methods
    private func setupView() {
        if likedIDs.isEmpty {
            view.backgroundColor = .screenBackground
            setupNavBar(emptyNFTs: true)
        } else {
            self.view = FavoritesView(frame: .zero, viewModel: self.viewModel)
            setupNavBar(emptyNFTs: false)
        }
    }
    
    private func setupNavBar(emptyNFTs: Bool) {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        backButton.accessibilityIdentifier = "backButton"
        if !emptyNFTs {
            navigationItem.title = L10n.Profile.nftFavorites
        }
    }
}
