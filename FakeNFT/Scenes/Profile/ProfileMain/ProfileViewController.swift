//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    private let viewModel: ProfileViewModelProtocol
    
    private let assetNameLabel: [String] = [
        L10n.Profile.myNFT,
        L10n.Profile.nftFavorites,
        L10n.Profile.aboutDeveloper
    ]
    
    private lazy var assetValue: [String?] = [
        "\(viewModel.profile?.nfts.count ?? 0)",
        "\(viewModel.profile?.likes.count ?? 0)",
        nil
    ]
    // MARK: - Layout view
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
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
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
        label.attributedText = NSAttributedString(string: "", attributes: [.kern: 0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupConstraints()
        view.backgroundColor = .screenBackground
        setupNavBar()
        UIBlockingProgressHUD.show()
        viewModel.getProfileData()
        UIBlockingProgressHUD.dismiss()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(likesUpdated),
            name: NSNotification.Name(rawValue: "likesUpdated"),
            object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func updateViews(
        profile: ProfileModel?
    ) {
        avatarImage.loadImage(
            urlString: profile?.avatar,
            placeholder: Asset.profile.image,
            radius: 35
        )
        nameLabel.text = profile?.name
        descriptionLabel.text = profile?.description
        websiteLabel.text = profile?.website
        
        let stringNftsCount = "(\(profile?.nfts.count ?? 0))"
        let stringLikesCount = "(\(profile?.likes.count ?? 0))"
        
        let myNFTCell = profileAssetsTable.cellForRow(at: [0, 0]) as? ProfileAssetsCell
        myNFTCell?.setAssets(label: nil, value: stringNftsCount)
        
        let likesCell = profileAssetsTable.cellForRow(at: [0, 1]) as? ProfileAssetsCell
        likesCell?.setAssets(label: nil, value: stringLikesCount)
    }
    
    @objc private func websiteDidTap(_ sender: UITapGestureRecognizer) {
        self.present(WebsiteViewController(link: viewModel.profile?.website), animated: true)
    }
    
    @objc private func likesUpdated(notification: Notification) {
        guard let likesUpdated = notification.object as? Int else { return }
        let cell = profileAssetsTable.cellForRow(at: [0, 1]) as? ProfileAssetsCell
        cell?.setAssets(label: nil, value: "(\(likesUpdated))")
    }
    
    private func bind() {
        if viewModel.isCheckConnectToInternet() {
            viewModel.onChange = { [weak self] in
                self?.updateViews(profile: self?.viewModel.profile)
            }
        } else {
            viewModel.onError = { [weak self] in
                UIBlockingProgressHUD.dismiss()
                self?.view = NoContentView(frame: .zero, noContent: .noInternet)
                self?.navigationController?.navigationBar.isHidden = true
            }
        }
    }
    
    private func setupNavBar() {
        (navigationController as? NavigationController)?.editProfileButtonDelegate = self
        navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupConstraints() {
        [avatarImage,
         nameLabel,
         descriptionLabel,
         websiteLabel,
         profileAssetsTable].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            // фотка профиля
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            // лейбл с именем юзера
            nameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            // описание интересов юзера
            descriptionLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 72),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            // лейбл с веб-сайтом юзера
            websiteLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            websiteLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            // таблица с разделами (мои нфт, избранное, о разработчике)
            profileAssetsTable.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 40),
            profileAssetsTable.heightAnchor.constraint(equalToConstant: 54 * 3),
            profileAssetsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileAssetsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Extensions
// возвращаем кол-во строк в таблице
extension ProfileViewController: UITableViewDataSource {
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
// навигация пользователя при выборе строк из таблицы: создание и отображение экранов в зависимости от выбора пользователя
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let profile = viewModel.profile else { return }
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(MyNFTViewController(viewModel: MyNFTViewModel(profile: profile)), animated: true)
        case 1:
            navigationController?.pushViewController(FavoritesViewController(viewModel: FavoritesViewModel(profile: profile)), animated: true)
        case 2:
            navigationController?.pushViewController(WebsiteViewController(), animated: true)
        default:
            return
        }
    }
}
// переход к экрану редактирования профиля при нажатии на кнопку редактирования
extension ProfileViewController: EditProfileButtonDelegate {
    func proceedToEditing() {
        guard let profile = viewModel.profile else { return }
        present(EditProfileViewController(viewModel: EditProfileViewModel(profile: profile), delegate: self), animated: true)
    }
}
// обновление данных профиля
extension ProfileViewController: ProfileUpdateDelegate {
    func update() {
        viewModel.getProfileData()
        bind()
        UIBlockingProgressHUD.dismiss()
    }
}
