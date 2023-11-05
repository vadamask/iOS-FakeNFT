import UIKit
import SnapKit

final class CatalogViewController: UITableViewController {
    private let viewModel = CatalogViewModel()
    let servicesAssembly: ServicesAssembly
    // let testNftButton = UIButton()

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
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
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        tableView.register(CatalogCell.self)

        bind()
        viewModel.viewDidLoaded()
//        view.addSubview(testNftButton)
//        testNftButton.constraintCenters(to: view)
//        testNftButton.setTitle(Constants.openNftTitle, for: .normal)
//        testNftButton.addTarget(self, action: #selector(showNft), for: .touchUpInside)
//        testNftButton.setTitleColor(.systemBlue, for: .normal)
    }

    func bind() {
        viewModel.$cellViewModels.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    @objc func sortButtonTapped() {
        print("Sorting")
    }

    @objc func showNft() {
        let assembly = NftDetailAssembly(servicesAssembler: servicesAssembly)
        let nftInput = NftDetailInput(id: Constants.testNftId)
        let nftViewController = assembly.build(with: nftInput)
        present(nftViewController, animated: true)
    }
}

private enum Constants {
    static let openNftTitle = L10n.Catalog.openNft
    static let testNftId = "22"
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
