//
//  UserViewController.swift
//  FakeNFT
//
//  Created by Artem Adiev on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit

final class UserViewController: UIViewController {

    // MARK: - UI elements
    private let userImageView: UIImageView = {
        let userImageView = UIImageView()
        userImageView.layer.cornerRadius = 35
        userImageView.clipsToBounds = true
        userImageView.image = UIImage(asset: Asset.beigeGus)
        return userImageView
    }()

    // TODO: Локализовать
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.headline22
        nameLabel.textColor = .textPrimary
        nameLabel.text = "Joaquin Phoenix"
        return nameLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.caption13
        descriptionLabel.numberOfLines = 4
        descriptionLabel.text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        return descriptionLabel
    }()

    private let websiteButton: UIButton = {
        let websiteButton = UIButton()
        websiteButton.layer.cornerRadius = 16
        websiteButton.layer.borderColor = UIColor.borderColor.cgColor
        websiteButton.layer.borderWidth = 1.0
        websiteButton.titleLabel?.font = UIFont.caption15
        websiteButton.setTitleColor(.textPrimary, for: .normal)
        websiteButton.setTitle("Перейти на сайт пользователя", for: .normal)
        return websiteButton
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    // MARK: - Setup UI
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CollectionCountCell.self)

        view.backgroundColor = .screenBackground
        view.addSubview(userImageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(websiteButton)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(70)
        }

        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView.snp.centerY)
            make.leading.equalTo(userImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        websiteButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(343)
            make.height.equalTo(40)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(websiteButton.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(380)
        }
    }
}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollectionCountCell = tableView.dequeueReusableCell()
        return cell
    }
}
// MARK: - UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    // Тут будет вызов WebView
}
