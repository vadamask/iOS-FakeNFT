//
//  RatingViewController.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import UIKit
import SnapKit

final class RatingViewController: UIViewController {
    // TODO: Реализовать безопасный анврап
    private var viewModel: RatingViewModel!

    // MARK: UI elements
    private var sortButton: UIBarButtonItem?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 16
        return tableView
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = RatingViewModel()
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        setupUI()
        viewModel.fetchUsers()
    }

    private func setupUI() {
        view.backgroundColor = .screenBackground
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        sortButton = UIBarButtonItem(image: UIImage(asset: Asset.sortButton), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton?.tintColor = .yaBlack
        guard let sortButton = sortButton else { return }
        navigationItem.rightBarButtonItem = sortButton
    }

    @objc private func sortButtonTapped() {
        // TODO: Локализовать
        let alertController = UIAlertController(title: nil, message: "Сортировка", preferredStyle: .actionSheet)

        let sortByNameAction = UIAlertAction(title: "По имени", style: .default) { _ in
            self.viewModel.sortByName()
        }
        alertController.addAction(sortByNameAction)

        let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { _ in
            self.viewModel.sortByRating()
        }
        alertController.addAction(sortByRatingAction)

        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RatingTableViewCell.self, forCellReuseIdentifier: "RatingTableViewCell")

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: UITableViewDataSource
extension RatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell

        let user = viewModel.getUser(at: indexPath)
        cell.configure(with: user, at: indexPath.row + 1)

        return cell
    }
}

// MARK: UITableViewDelegate
extension RatingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
