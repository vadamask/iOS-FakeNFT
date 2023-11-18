//
//  ProfileView.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import Kingfisher
import UIKit

final class ProfileView: UIView {
    private var viewController: ProfileViewController?
    
    private let assetLabel: [String] = [
        L10n.Profile.myNFT,
        L10n.Profile.nftFavorites,
        L10n.Profile.aboutDeveloper
    ]
    
    private let assetViewController: [UIViewController] = [
        ProfileMyNFTViewController(),
        ProfileFavoritesViewController(),
        ProfileDevelopersViewController()
    ]
    
    // MARK: - Layout view
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.profile.image
        imageView.layer.cornerRadius = 35
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .headline22
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .textPrimary
        label.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 18
        label.attributedText = NSAttributedString(string: "", attributes: [.kern: 0.08,NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // www ссылка
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.font = .caption15
        label.textColor = .blue
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(websiteDidTap))
        label.attributedText = NSAttributedString(string: "", attributes: [.kern: 0.24])
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapAction)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // тейбл вью
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.register(ProfileCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(frame: CGRect, viewController: ProfileViewController) {
        super.init(frame: .zero)
        self.viewController = viewController
        self.backgroundColor = .screenBackground
        addProfileImage()
        addUsernameLabel()
        addDescriptionLabel()
        addWebsiteLabel()
        addcategoryTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func websiteDidTap(_ sender: UITapGestureRecognizer) {
        viewController?.present(WebsiteViewController(webView: nil, websiteURL: websiteLabel.text), animated: true)
    }
    
    func updateViews(
        avatarURL: URL?,
        userName: String?,
        description: String?,
        website: String?,
        nftCount: String?,
        likesCount: String?
    ) {
        profileImage.kf.setImage(
            with: avatarURL,
            placeholder: Asset.profile.image,
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 35))])
        usernameLabel.text = userName
        descriptionLabel.text = description
        websiteLabel.text = website
        
        let nftsCountLabel = categoryTableView.cellForRow(at: [0,0]) as? ProfileCell
        nftsCountLabel?.valueInSection.text = nftCount
        let likesCountLabel = categoryTableView.cellForRow(at: [0,1]) as? ProfileCell
        likesCountLabel?.valueInSection.text = likesCount
    }
    
    // MARK: - Layout constraints
    func addProfileImage() {
        addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    func addUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 21).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16).isActive = true
    }
    
    private func addDescriptionLabel() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 72),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func addWebsiteLabel() {
        addSubview(websiteLabel)
        NSLayoutConstraint.activate([
            websiteLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            websiteLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
        ])
    }
    
    private func addcategoryTableView() {
        addSubview(categoryTableView)
        NSLayoutConstraint.activate([
            categoryTableView.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 40),
            categoryTableView.heightAnchor.constraint(equalToConstant: 54 * 3),
            categoryTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

// MARK: - Extensions
// возвращаем кол-во строк в таблице
extension ProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // настройка ячейки строки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileCell = tableView.dequeueReusableCell()
        
        cell.backgroundColor = .screenBackground
        cell.textInSection.text = assetLabel[indexPath.row]
        cell.valueInSection.text = ""
        cell.selectionStyle = .none
        return cell
    }
    
    // высота строки ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

extension ProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.navigationController?.pushViewController(assetViewController[indexPath.row], animated: true)
    }
}
