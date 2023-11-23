//
//  ProfileMyNFTViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 15.11.2023.
//

import UIKit

final class MyNFTViewController: UIViewController, UIGestureRecognizerDelegate {
    private let viewModel: MyNFTViewModelProtocol
    
    private let nftsID: [String]
    private let likedsID: [String]
    private var badConnection: Bool = false
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
    // кнопка сортировки
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.sortButton.image,
            style: .plain,
            target: self,
            action: #selector(didTapSortButton))
        button.tintColor = .textPrimary
        return button
    }()
    // лейбл при отсутствии нфт
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.emptyNFTLabel // У вас ещё нет NFT
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(nftIDs: [String], likedIDs: [String]) {
        self.nftsID = nftIDs
        self.likedsID = likedIDs
        self.viewModel = MyNFTViewModel(nftIDs: nftIDs, likedIDs: likedIDs)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupView()
        addEdgeSwipeBackGesture()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let sortOrder = UserDefaults.standard.data(forKey: "sortOrder") {
            let order = try? PropertyListDecoder().decode(MyNFTViewModel.Sort.self, from: sortOrder)
            self.viewModel.sort = order
        } else {
            self.viewModel.sort = .rating
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if badConnection { viewModel.getMyNFTs(nftIDs: nftsID) }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func bind() {
        viewModel.onChange = { [weak self] in
            self?.badConnection = false
            guard let view = self?.view as? MyNFTView,
                  let nfts = self?.viewModel.myNFTs else { return }
            view.updateNFT(nfts: nfts)
        }
        
        viewModel.onError = { [weak self] error in
            self?.badConnection = true
            let alert = UIAlertController(
                title: "Нет интернета",
                message: error.localizedDescription,
                preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSortButton() {} // функция сортировки
    
    private func setupView() {
        if nftsID.isEmpty {
            view.backgroundColor = .white
            setupNavBar(emptyNFTs: true)
            setupEmptyLabel()
        } else {
            self.view = MyNFTView(frame: .zero, viewModel: self.viewModel)
            setupNavBar(emptyNFTs: false)
        }
    }
    
    func setupNavBar(emptyNFTs: Bool) {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .screenBackground
        backButton.accessibilityIdentifier = "backButton"
        if !emptyNFTs {
            navigationItem.rightBarButtonItem = sortButton
            navigationItem.title = "Мои NFT"
        }
    }
    
    func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
