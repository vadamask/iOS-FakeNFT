import UIKit
import SnapKit
import Combine

final class CatalogViewController: UICollectionViewController, LoadingView, ErrorView {
    enum Section {
        case main
    }
    internal lazy var activityIndicator = UIActivityIndicatorView()
    typealias DataSource = UICollectionViewDiffableDataSource<Section, CatalogCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CatalogCellViewModel>
    private var subscriptions = Set<AnyCancellable>()
    private lazy var dataSource = makeDataSource()
    private let viewModel: CatalogViewModelProtocol

    private lazy var sortButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.sortButton.image,
            style: .done,
            target: self,
            action: #selector(sortButtonTapped)
        )
        button.isEnabled = false
        return button
    }()

    init(viewModel: CatalogViewModelProtocol, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    deinit {
        for subscription in subscriptions {
            subscription.cancel()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: Setup navbar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .screenBackground
        navigationController?.navigationBar.standardAppearance = appearance

        // MARK: Theme of nav bar
        navigationController?.navigationBar.tintColor = .segmentActive
        navigationItem.backButtonTitle = ""
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppStoreReviewManager.requestReviewIfAppropriate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Configuring sort button item right side
        navigationItem.rightBarButtonItem = sortButtonItem

        // MARK: Configuring collectionView
        collectionView.backgroundColor = .screenBackground
        collectionView.refreshControl = UIRefreshControl()
        collectionView.backgroundView = activityIndicator
        collectionView.register(CatalogCell.self)
        collectionView.register(CatalogCellPlaceholder.self)

        // MARK: add action for refresh control
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
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                switch newState {
                case .initial:
                    self?.sortButtonItem.isEnabled = false
                    self?.collectionView.isUserInteractionEnabled = false
                    self?.applySnapshot()
                case .loading:
                    self?.sortButtonItem.isEnabled = false
                    self?.showLoading()
                case .refreshing, .sorting:
                    self?.sortButtonItem.isEnabled = false
                case .error:
                    self?.sortButtonItem.isEnabled = false
                    self?.collectionView.isUserInteractionEnabled = true
                    self?.hideLoading()
                    self?.showError(
                        ErrorModel(
                            message: L10n.Error.unableToLoad,
                            actionText: L10n.Error.repeat
                        ) {
                            self?.viewModel.loadCollections()
                        }
                    )
                case .ready:
                    self?.collectionView.isUserInteractionEnabled = true
                    self?.sortButtonItem.isEnabled = true
                    self?.hideLoading()
                    self?.applySnapshot()
                    self?.collectionView.refreshControl?.endRefreshing()
                }
            }
            .store(in: &subscriptions)
    }

    @objc private func refreshCatalog() {
        viewModel.refreshCollections()
    }

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, catalogCellViewModel -> UICollectionViewCell? in
            if case .loading = self?.viewModel.state.value {
                let cell: CatalogCellPlaceholder = collectionView.dequeueReusableCell(indexPath: indexPath)
                return cell
            } else {
                let cell: CatalogCell = collectionView.dequeueReusableCell(indexPath: indexPath)
                cell.viewModel = catalogCellViewModel
                return cell
            }
        }
        return dataSource
    }

    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.cellViewModels)
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
}

extension CatalogViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell: CatalogCell = collectionView.getCell(indexPath: indexPath)
        guard let collectionId = cell.viewModel?.id else {
            return
        }
        viewModel.navigateToCollectionWith(id: collectionId)
    }
}
