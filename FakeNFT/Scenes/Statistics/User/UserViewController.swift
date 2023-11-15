//
//  UserViewController.swift
//  FakeNFT
//
//  Created by Artem Adiev on 09.11.2023.
//

import Kingfisher
import SnapKit
import UIKit

final class UserViewController: UIViewController {
    private var viewModel: UserViewModel?
    private var user: User?
    private var nftCount = 0
    private var userWebSiteUrl = URL(string: "")

    // MARK: - UI elements
    private let userImageView: UIImageView = {
        let userImageView = UIImageView()
        userImageView.layer.cornerRadius = 35
        userImageView.clipsToBounds = true
        userImageView.isHidden = true
        return userImageView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.headline22
        nameLabel.textColor = .textPrimary
        nameLabel.isHidden = true
        return nameLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.caption13
        descriptionLabel.numberOfLines = 4
        descriptionLabel.isHidden = true
        return descriptionLabel
    }()

    private lazy var websiteButton: UIButton = {
        let websiteButton = UIButton()
        websiteButton.layer.cornerRadius = 16
        websiteButton.layer.borderColor = UIColor.borderColor.cgColor
        websiteButton.layer.borderWidth = 1.0
        websiteButton.titleLabel?.font = UIFont.caption15
        websiteButton.setTitleColor(.textPrimary, for: .normal)
        websiteButton.setTitle(L10n.User.visitWebSite, for: .normal)
        websiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
        websiteButton.isHidden = true
        return websiteButton
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        return tableView
    }()

    // MARK: - Init
    init(userId: String) {
        super.init(nibName: nil, bundle: nil)
        configureViewModel(with: userId)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.showLoading = {
            self.showLoading()
        }

        viewModel?.hideLoading = {
            self.hideLoading()
        }

        viewModel?.fetchUserDetails()
        setupViews()
        setupConstraints()
    }

    @objc private func websiteButtonTapped() {
        guard let url = userWebSiteUrl else {
            print("Неверный URL")
            return
        }
        let userWebViewController = UserWebViewController(url: url)
        present(userWebViewController, animated: true)
    }

    // MARK: - Setup UI
    private func configureViewModel(with userId: String) {
        let viewModel = UserViewModel(networkClient: DefaultNetworkClient(), userId: userId)
        viewModel.userDetailsUpdated = { [weak self] user in
            DispatchQueue.main.async {
                self?.updateUI(with: user)
            }
        }
        self.viewModel = viewModel
    }

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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func makeVisible() {
        userImageView.isHidden = false
        nameLabel.isHidden = false
        descriptionLabel.isHidden = false
        websiteButton.isHidden = false
        tableView.isHidden = false
    }

    private func updateUI(with user: User) {
        userImageView.kf.setImage(with: user.avatar)
        nameLabel.text = user.name
        nftCount = user.nfts.count
        descriptionLabel.text = user.description
        userWebSiteUrl = user.website
        tableView.reloadData()
        makeVisible()
    }
}

// MARK: - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollectionCountCell = tableView.dequeueReusableCell()

        cell.set(count: nftCount)
        print("nftCount: \(nftCount)")
        return cell
    }
}
// MARK: - UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    // Тут будет вызов экрана коллекции NFT
}

// MARK: - Extensions
extension UserViewController: LoadingView {}
