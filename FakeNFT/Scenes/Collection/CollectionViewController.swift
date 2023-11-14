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
    private lazy var dataSource = makeDataSource()
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: CollectionViewModelProtocol

    init(viewModel: CollectionViewModelProtocol, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationItem.standardAppearance = appearance

        collectionView.refreshControl = UIRefreshControl()
        collectionView.backgroundColor = .screenBackground
        collectionView.backgroundView = activityIndicator
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.registerHeaderView(CollectionHeader.self)
        collectionView.register(CollectionCell.self)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        bind()

        viewModel.loadCollection()
    }

    private func bind() {
        viewModel.statePublisher.sink { [weak self] state in
            switch state {
            case .loading:
                self?.showLoading()
            case .loaded:
                self?.hideLoading()
                self?.applySnapshot()
            case .error(let error):
                self?.showError(
                    ErrorModel(message: error.localizedDescription, actionText: "Повторить") {
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
        else {
            return
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }
}
