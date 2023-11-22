//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import UIKit
import Combine
import SnapKit

final class CollectionViewController: UICollectionViewController, LoadingView, ErrorView {
    internal lazy var activityIndicator = UIActivityIndicatorView()
    typealias DataSource = UICollectionViewDiffableDataSource<CollectionHeaderViewModel, CollectionCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionHeaderViewModel, CollectionCellViewModel>
    private var subscriptions = Set<AnyCancellable>()
    private var cellSubscriptions = Set<AnyCancellable>()
    private lazy var dataSource = makeDataSource()
    private let viewModel: CollectionViewModelProtocol

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }
    
    init(viewModel: CollectionViewModelProtocol, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: Setup navbar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance

        // MARK: Theme of nav bar
        navigationController?.navigationBar.tintColor = .segmentActive
        navigationItem.backButtonTitle = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Configure collectionView
        collectionView.contentInset.bottom = 35
        collectionView.backgroundColor = .screenBackground
        collectionView.backgroundView = activityIndicator
        collectionView.contentInsetAdjustmentBehavior = .never

        // MARK: reuse registration
        collectionView.registerHeaderView(CollectionHeader.self)
        collectionView.registerHeaderView(CollectionHeaderPlaceholder.self)
        collectionView.register(CollectionCell.self)
        collectionView.register(CollectionCellPlaceholder.self)

        setupConstraints()

        // MARK: Bindings MVVM
        bind()

        // MARK: View loaded and ready to load colection
        viewModel.loadCollection()
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func bind() {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .initial:
                    self?.collectionView.isUserInteractionEnabled = false
                    self?.applySnapshot()
                case .loading:
                    self?.collectionView.isUserInteractionEnabled = false
                    self?.showLoading()
                case .loaded:
                    self?.collectionView.isUserInteractionEnabled = true
                    self?.hideLoading()
                    self?.applySnapshot()
                case .error:
                    self?.showError(
                        ErrorModel(
                            message: L10n.Error.unableToLoad,
                            actionText: L10n.Error.repeat
                        ) {
                            self?.viewModel.loadCollection()
                        }
                    )
                }
            }
            .store(in: &subscriptions)
    }

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, collectionCellViewModel -> UICollectionViewCell? in
            if case .loading = self?.viewModel.state.value {
                let cell: CollectionCellPlaceholder = collectionView.dequeueReusableCell(indexPath: indexPath)
                return cell
            } else {
                let cell: CollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
                cell.viewModel = collectionCellViewModel
                cell.likeAction.sink { [weak self] id, isLiked in
                    self?.viewModel.likeNftWith(id: id, isLiked: isLiked)
                }
                .store(in: &cell.subscriptions)
                cell.cartAction.sink { [weak self] id, inOrder in
                    if inOrder {
                        self?.viewModel.addToCartNftWith(id: id)
                    } else {
                        self?.viewModel.removeFromCartNftWith(id: id)
                    }
                }
                .store(in: &cell.subscriptions)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            if case .loading = self?.viewModel.state.value {
                let headerView: CollectionHeaderPlaceholder = collectionView.dequeueReusableView(
                    ofKind: kind, indexPath: indexPath
                )
                return headerView
            } else {
                let headerView: CollectionHeader = collectionView.dequeueReusableView(
                    ofKind: kind, indexPath: indexPath
                )
                headerView.subscription = headerView.authorAction.sink { [weak self] url in
                    self?.viewModel.navigateToAuthorPage(url: url)
                }
                headerView.viewModel = self?.viewModel.headerViewModel
                return headerView
            }
        }
        return dataSource
    }

    func applySnapshot() {
        guard let headerViewModel = viewModel.headerViewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([headerViewModel])
        snapshot.appendItems(viewModel.cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
