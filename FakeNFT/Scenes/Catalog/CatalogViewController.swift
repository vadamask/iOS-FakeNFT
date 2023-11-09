import UIKit
import SnapKit
import Combine

final class CatalogViewController: UITableViewController, LoadingView, ErrorView {
    internal lazy var activityIndicator = UIActivityIndicatorView()
    private let viewModel: CatalogViewModelProtocol
    private var subscriptions = Set<AnyCancellable>()

    init(servicesAssembly: ServicesAssembly) {
        self.viewModel = CatalogViewModel(service: servicesAssembly.nftService)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .screenBackground

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

        // MARK: Configuring tableView
        refreshControl = UIRefreshControl()
        tableView.backgroundView = activityIndicator
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        tableView.register(CatalogCell.self)

        refreshControl?.addTarget(self, action: #selector(refreshCatalog), for: .valueChanged)

        // MARK: Bindings MVVM
        bind()

        // MARK: View loaded and ready to load colections
        viewModel.loadCollections()
    }

    @objc func sortButtonTapped() {
        showSortingMenu()
    }

    func bind() {
        viewModel.statePublisher.sink { [weak self] newState in
            switch newState {
            case .sorting: break
            case .loading:
                self?.showLoading()
            case .failed:
                self?.hideLoading()
                self?.showError(ErrorModel(message: L10n.Error.unableToLoad, actionText: L10n.Error.repeat, action: {
                    self?.viewModel.loadCollections()
                }))
            case .ready:
                self?.hideLoading()
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
        .store(in: &subscriptions)
    }

    @objc private func refreshCatalog() {
        viewModel.loadCollections()
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CatalogCell = tableView.dequeueReusableCell()
        cell.viewModel = viewModel.cellViewModels?[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionViewController = CollectionViewController()
        collectionViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(collectionViewController, animated: true)
    }
}
