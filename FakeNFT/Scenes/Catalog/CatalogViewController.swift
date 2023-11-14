import UIKit
import SnapKit
import Combine

final class CatalogViewController: UICollectionViewController, LoadingView, ErrorView {
    enum Section {
        case main
    }
    internal lazy var activityIndicator = UIActivityIndicatorView()
    private let viewModel: CatalogViewModelProtocol
    private var subscriptions = Set<AnyCancellable>()

    typealias DataSource = UICollectionViewDiffableDataSource<Section, CatalogCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CatalogCellViewModel>
    private lazy var dataSource = makeDataSource()

    init(viewModel: CatalogViewModelProtocol, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .screenBackground
        navigationItem.standardAppearance = appearance

        // MARK: Theme of nav bar
        navigationController?.navigationBar.tintColor = .segmentActive
        navigationItem.backButtonTitle = ""

        // MARK: Configuring sort button item right side
        let sortButtonItem = UIBarButtonItem(
            image: Asset.sortButton.image,
            style: .done,
            target: self,
            action: #selector(sortButtonTapped)
        )
        navigationItem.rightBarButtonItem = sortButtonItem

        // MARK: Configuring collectionView
        collectionView.backgroundColor = .screenBackground
        collectionView.refreshControl = UIRefreshControl()
        collectionView.backgroundView = activityIndicator
        collectionView.register(CatalogCell.self)

        collectionView.refreshControl?.addTarget(self, action: #selector(refreshCatalog), for: .valueChanged)

        // MARK: Bindings MVVM
        bind()

        // MARK: View loaded and ready to load colections
        viewModel.loadCollections()
    }

    @objc func sortButtonTapped() {
        showSortingMenu()
    }

    private func bind() {
        viewModel.statePublisher.sink { [weak self] newState in
            switch newState {
            case .sorting: break
            case .loading:
                self?.showLoading()
            case .error:
                self?.hideLoading()
                self?.showError(ErrorModel(message: L10n.Error.unableToLoad, actionText: L10n.Error.repeat, action: {
                    self?.viewModel.loadCollections()
                }))
            case .ready:
                self?.hideLoading()
                self?.applySnapshot()
                self?.collectionView.refreshControl?.endRefreshing()
            }
        }
        .store(in: &subscriptions)
    }

    @objc private func refreshCatalog() {
        viewModel.loadCollections()
    }

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, catalogCellViewModel -> UICollectionViewCell? in
            let cell: CatalogCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = catalogCellViewModel
            return cell
        }
        return dataSource
    }

    private func applySnapshot() {
        guard let cellViewModels = viewModel.cellViewModels else {
            return
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func showSortingMenu() {
        let title = L10n.Catalog.sorting
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
        let sortByNameAction = UIAlertAction(
            title: L10n.Catalog.sortByName,
            style: UIAlertAction.Style.default) { [weak self] _ in
                self?.viewModel.changeSorting(to: .byNameAsc)
        }
        let sortByNftCountAction = UIAlertAction(
            title: L10n.Catalog.sortByNftCount,
            style: UIAlertAction.Style.default) { [weak self] _ in
                self?.viewModel.changeSorting(to: .byNftCountDesc)
        }
        let closeAction = UIAlertAction(title: L10n.close, style: .cancel)
        alert.addAction(sortByNameAction)
        alert.addAction(sortByNftCountAction)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }
}

extension CatalogViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let collectionId = viewModel.cellViewModels?[indexPath.row].id else {
            return
        }
        let viewModel = CollectionViewModel(
            collectionId: collectionId,
            service: ServicesAssembly.shared.nftService)
        let collectionViewController = CollectionViewController(
            viewModel: viewModel,
            layout: CollectionLayout())
        collectionViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(collectionViewController, animated: true)
    }
}
