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
    
    //MARK: - Layout view
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.profile.image
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .headline22
        label.textColor = .textPrimary // black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.text = ""
        label.textColor = .textPrimary // black
        label.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle() // переменная настройки стиля параграфа
        label.attributedText = NSAttributedString(
            string: descriptionLabel.text ?? "",
            attributes: [.kern: 0.08, // расстояние между символами
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // www ссылка
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.font = .caption15
        label.text = ""
        label.textColor = .blue // убрать?
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(websiteDidTap))
        label.attributedText = NSAttributedString(string: websiteLabel.text ?? "", attributes: [.kern: 0.24])
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapAction)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self // добавить датасорс
        tableView.delegate = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell") // регистрация ячейки
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
        //dataForProfile()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func websiteDidTap(_ sender: UITapGestureRecognizer) {
        viewController?.present(WebsiteViewController(webView: nil, websiteURL: websiteLabel.text), animated: true)
    }
    
    //MARK: - Layout constraints
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
            websiteLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor)
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
    
    func updateViews(
        userImageURL: URL?,
        userName: String?,
        description: String?,
        website: String?,
        nftCount: String?,
        likesCount: String?) {
            func dataForProfile() {
                profileImage.kf.setImage(
                    with: userImageURL,
                    placeholder: UIImage(named: "Profile"),
                    options: [.processor(RoundCornerImageProcessor(cornerRadius: 35))])
                
                usernameLabel.text = userName
                descriptionLabel.text = description
                websiteLabel.text = website
                let nftsCountLabel = categoryTableView.cellForRow(at: [0,0]) as? ProfileCell
                nftsCountLabel?.textInSection.text = nftCount
                let likesCountLabel = categoryTableView.cellForRow(at: [0,1]) as? ProfileCell
                likesCountLabel?.valueInSection.text = likesCount
            }
        }
}



//MARK: - Extensions
// возвращаем кол-во строк в таблице
extension ProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // настройка ячейки строки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath as IndexPath) as? ProfileCell else { return ProfileCell() }
        switch indexPath.row {
            case 0:
                cell.textInSection.text = "Мои NFT"
                cell.valueInSection.text = "(0)"
            case 1:
                cell.textInSection.text = "Избранные NFT"
                cell.valueInSection.text = "(0)"
            case 2:
                cell.textInSection.text = "О разработчике"
                cell.valueInSection.text = ""
            default:
                cell.textInSection.text = ""
                cell.valueInSection.text = ""
        }
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
        switch indexPath.row {
        case 0:
            print("Мои NFT")
        case 1:
            print("Избранные NFT")
        case 2:
            print("О разработчике")
        default:
            return
        }
    }
}
