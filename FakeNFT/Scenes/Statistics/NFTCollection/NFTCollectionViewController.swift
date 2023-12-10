//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Artem Adiev on 15.11.2023.
//

import UIKit

final class NFTCollectionViewController: UIViewController {
    private let viewModel: NFTCollectionViewModel

    // MARK: - Properties
    private var nftIds: [String] = []
    private var nfts: [Nft] = []

    // MARK: - UI elements
    private lazy var collectionView: UICollectionView = {
        let layout = NftCollectionLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    // MARK: - Init
    init(nftIds: [String]) {
        self.viewModel = NFTCollectionViewModel(networkClient: DefaultNetworkClient(), nftIds: nftIds)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()

        setupUI()

        viewModel.fetchNftCollection()
    }

    // MARK: - Setup UI
    private func setupViewModel() {
        viewModel.reloadCollectionViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.nfts = self?.viewModel.nftCollection ?? []
                self?.collectionView.reloadData()
            }
        }

        viewModel.showLoading = {
            UIBlockingProgressHUD.show()
        }
        viewModel.hideLoading = {
            UIBlockingProgressHUD.dismiss()
        }
    }

    private func setupUI() {
        view.backgroundColor = .screenBackground
        setupNavigationBar()
        setupCollectionView()
    }

    private func setupNavigationBar() {
        let tabBarItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = tabBarItem
        navigationItem.title = L10n.User.nftCollection
        navigationController?.navigationBar.tintColor = .segmentActive
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 108, height: 192)

        collectionView.register(CollectionCell.self)

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - CollectionViewDataSource
extension NFTCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nfts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let nft = nfts[indexPath.item]
        let viewModel = CollectionCellViewModel(
            id: nft.id,
            imageUrls: nft.images,
            isLiked: false,
            name: nft.name,
            rating: nft.rating,
            price: Double(nft.price),
            inOrder: false
        )
        cell.viewModel = viewModel
        return cell
    }
}

// MARK: - CollectionViewDelegate
extension NFTCollectionViewController: UICollectionViewDelegate {}
