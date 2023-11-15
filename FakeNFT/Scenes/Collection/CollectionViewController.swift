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
    enum Section {
        case main
    }
    internal lazy var activityIndicator = UIActivityIndicatorView()
    typealias DataSource = UICollectionViewDiffableDataSource<Section, CollectionCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CollectionCellViewModel>
    private var subscriptions = Set<AnyCancellable>()
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
        collectionView.refreshControl = UIRefreshControl()
        collectionView.backgroundColor = .screenBackground
        collectionView.backgroundView = activityIndicator
        collectionView.contentInsetAdjustmentBehavior = .never

        // MARK: reuse registration
        collectionView.registerHeaderView(CollectionHeader.self)
        collectionView.register(CollectionCell.self)

        setupConstraints()

        // MARK: Bindings MVVM
        bind()

        // MARK: View loaded and ready to load colection
        viewModel.loadCollection()
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func bind() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.showLoading()
                case .loaded:
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
        ) { collectionView, indexPath, collectionCellViewModel -> UICollectionViewCell? in
            let cell: CollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = collectionCellViewModel
            return cell
        }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let headerView: CollectionHeader = collectionView.dequeueReusableView(
                ofKind: kind, indexPath: indexPath
            )
            headerView.onNameAuthorLabelClicked = { authorUrlString in
                let webViewVC = WebViewController(url: authorUrlString)
                self?.navigationController?.pushViewController(webViewVC, animated: true)
            }
            headerView.viewModel = self?.viewModel.headerViewModel
            return headerView
        }
        return dataSource
    }

    func applySnapshot() {
        guard
            viewModel.headerViewModel != nil,
            let cellViewModels = viewModel.cellViewModels
        else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
