//
//  RatingViewController.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import UIKit
import SnapKit

final class RatingViewController: UIViewController {

    // MARK: UI elements

    private var sortButton: UIBarButtonItem?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 16
        return tableView
    }()

    // MARK: - Mock data
    private let userArray: [User] = [
        User(image: Asset.blueLoki.image, name: "Alex", score: 112),
        User(image: Asset.blueLoki.image, name: "Bill", score: 98),
        User(image: Asset.blueLoki.image, name: "Alla", score: 72),
        User(image: Asset.blueLoki.image, name: "Mads", score: 71),
        User(image: Asset.blueLoki.image, name: "Timothée", score: 51),
        User(image: Asset.blueLoki.image, name: "Lea", score: 23),
        User(image: Asset.blueLoki.image, name: "Eric", score: 11)
    ]

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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

        let sortByNameAction = UIAlertAction(title: "По имени", style: .default) { action in
            // Тут сортируем по имени
        }
        alertController.addAction(sortByNameAction)

        let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { action in
            // Тут сортируем по рейтингу
        }
        alertController.addAction(sortByRatingAction)

        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel) { action in
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

extension RatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Вернуть количество элементов в массиве Рейтинга
        return userArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell

        let user = userArray[indexPath.row]
        cell.configure(with: user, at: indexPath.row + 1)

        return cell
    }
}

extension RatingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
