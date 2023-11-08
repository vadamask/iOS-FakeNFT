import UIKit
import SnapKit

final class CatalogViewController: UITableViewController, LoadingView {
    internal lazy var activityIndicator = UIActivityIndicatorView()
    private let viewModel: CatalogViewModel

    init(servicesAssembly: ServicesAssembly) {
        self.viewModel = CatalogViewModel(service: servicesAssembly.nftService)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .segmentActive
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .screenBackground

        // Configuring sort button item right side
        let sortButtonItem = UIBarButtonItem(
            image: Asset.sortButton.image,
            style: .done,
            target: self,
            action: #selector(sortButtonTapped)
        )
        navigationItem.rightBarButtonItem = sortButtonItem

        // Configuring tableView
        tableView.backgroundView = activityIndicator
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        tableView.register(CatalogCell.self)

        bind()
        viewModel.viewDidLoaded()
    }

    func bind() {
        viewModel.$state.bind { [weak self] newState in
            switch newState {
            case .initial, .sorting: break
            case .loading:
                self?.showLoading()
            case .failed:
                self?.hideLoading()
            case .ready:
                self?.hideLoading()
                self?.tableView.reloadData()
            }
        }
    }

    private func showSortingMenu() {
        let title = "Сортировка"
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
        let sortByNameAction = UIAlertAction(
            title: "По названию",
            style: UIAlertAction.Style.default) { [weak self] _ in
                self?.viewModel.changeSorting(to: .byNameAsc)
        }
        let sortByNftCountAction = UIAlertAction(
            title: "По количеству NFT",
            style: UIAlertAction.Style.default) { [weak self] _ in
                self?.viewModel.changeSorting(to: .byNftCountDesc)
        }
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(sortByNameAction)
        alert.addAction(sortByNftCountAction)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }

    @objc func sortButtonTapped() {
        showSortingMenu()
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
