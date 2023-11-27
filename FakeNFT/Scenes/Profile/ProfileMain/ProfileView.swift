//
//  ProfileView.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import Kingfisher
import UIKit

final class ProfileView: UIView {
    private var viewModel: ProfileViewModelProtocol
    private var viewController: ProfileViewController
    private var assetViewControllers: [UIViewController] = []
    
    private let assetNameLabel: [String] = [
        L10n.Profile.myNFT,
        L10n.Profile.nftFavorites,
        L10n.Profile.aboutDeveloper
    ]
    
    private lazy var assetValue: [String?] = [
        "\(viewModel.nfts?.count ?? 0)",
        "\(viewModel.likes?.count ?? 0)",
        nil
    ]
    
    // картинка профиля
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.profile.image
        imageView.layer.cornerRadius = 35
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // лейбл с именем юзера
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .headline22
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // раздел "О себе юзера"
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
    private lazy var profileAssetsTable: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.register(ProfileAssetsCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(frame: CGRect, viewModel: ProfileViewModelProtocol, viewController: ProfileViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero)
        
        self.backgroundColor = .screenBackground
        setupConstraints()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(likesUpdated),
            name: NSNotification.Name(rawValue: "likesUpdated"),
            object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initiateViewControllers() {
        let myNFTViewController = MyNFTViewController(nftIDs: viewModel.nfts ?? [], likedIDs: viewModel.likes ?? [])
        let favoritesViewController = FavoritesViewController(likedIDs: viewModel.likes ?? [])
        let developersViewController = DevelopersViewController()
        
        assetViewControllers = [myNFTViewController, favoritesViewController, developersViewController]
    }
    
    @objc private func websiteDidTap(_ sender: UITapGestureRecognizer) {
        viewController.present(WebsiteViewController(websiteURL: websiteLabel.text), animated: true)
    }
    
    @objc private func likesUpdated(notification: Notification) {
        guard let likesUpdated = notification.object as? Int else { return }
        let cell = profileAssetsTable.cellForRow(at: [0,1]) as? ProfileAssetsCell
        cell?.setAssets(label: nil, value: "(\(likesUpdated))")
    }
    
    func updateViews(
        avatarURL: URL?,
        userName: String?,
        description: String?,
        website: String?,
        nftCount: String?,
        likesCount: String?
    ) {
        avatarImage.kf.setImage(
            with: avatarURL,
            placeholder: UIImage(named: "Profile"),
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 35))])
        nameLabel.text = userName
        descriptionLabel.text = description
        websiteLabel.text = website
        
        let myNFTCell = profileAssetsTable.cellForRow(at: [0,0]) as? ProfileAssetsCell
        myNFTCell?.setAssets(label: nil, value: nftCount)
        
        let likesCell = profileAssetsTable.cellForRow(at: [0,1]) as? ProfileAssetsCell
        likesCell?.setAssets(label: nil, value: likesCount)
    }
    
    private func setupConstraints() {
        [avatarImage,
         nameLabel,
         descriptionLabel,
         websiteLabel,
         profileAssetsTable].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // фотка профиля
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            // лейбл с именем юзера
            nameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            // описание интересов юзера
            descriptionLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 72),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            // лейбл с веб-сайтом юзера
            websiteLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            websiteLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            // таблица с разделами (мои нфт, избранное, о разработчике)
            profileAssetsTable.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 40),
            profileAssetsTable.heightAnchor.constraint(equalToConstant: 54 * 3),
            profileAssetsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileAssetsTable.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

// возвращаем кол-во строк в таблице
extension ProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetNameLabel.count
    }
    
    // настройка ячейки строки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileAssetsCell = tableView.dequeueReusableCell()
        
        cell.backgroundColor = .screenBackground
        cell.setAssets(label: assetNameLabel[indexPath.row], value: assetValue[indexPath.row])
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
        viewController.navigationController?.pushViewController(self.assetViewControllers[indexPath.row], animated: true)
    }
}
