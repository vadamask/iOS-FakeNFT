//
//  RatingViewController.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import SnapKit
import UIKit

final class RatingViewController: UIViewController {
    private var viewModel: RatingViewModel

    // MARK: - UI elements
    private var sortButton: UIBarButtonItem?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    init(viewModel: RatingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.showLoading = {
            self.showLoading()
        }

        viewModel.hideLoading = {
            self.hideLoading()
        }

        setupUI()
        viewModel.fetchUsers()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .screenBackground
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .segmentActive
        let image = Asset.sortButton.image
        sortButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(sortButtonTapped))
        guard let sortButton = sortButton else { return }
        navigationItem.rightBarButtonItem = sortButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RatingCell.self)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Actions
    @objc private func sortButtonTapped() {
        let alertController = UIAlertController(title: nil, message: L10n.Sort.title, preferredStyle: .actionSheet)

        let sortByNameAction = UIAlertAction(title: L10n.Sort.byName, style: .default) { _ in
            self.viewModel.sortByName()
        }
        alertController.addAction(sortByNameAction)

        let sortByRatingAction = UIAlertAction(title: L10n.Sort.byRating, style: .default) { _ in
            self.viewModel.sortByRating()
        }
        alertController.addAction(sortByRatingAction)

        let cancelAction = UIAlertAction(title: L10n.Sort.close, style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension RatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RatingCell = tableView.dequeueReusableCell()

        let user = viewModel.getUser(at: indexPath)
        cell.configure(with: user, at: indexPath.row + 1)

        return cell
    }
}

// MARK: - UITableViewDelegate
extension RatingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.getUser(at: indexPath)
        viewModel.navigateToUserPage(userId: user.id)
    }
}

// MARK: - Extensions
extension RatingViewController: LoadingView {}
