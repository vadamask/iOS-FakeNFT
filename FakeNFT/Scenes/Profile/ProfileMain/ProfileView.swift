//
//  ProfileView.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileView: UIView {
    
    //MARK: - Layout view
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        //let placeholder = Asset.profile.image
        imageView.image = UIImage(named: "Profile")
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .headline22
        label.textColor = .yaBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption13
        label.textColor = .yaBlack
        label.numberOfLines = .zero
        let paragraphStyle = NSMutableParagraphStyle() // переменная настройки стиля параграфа
        label.attributedText = NSAttributedString(
            string: "",
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
        let websiteDidTap = UITapGestureRecognizer(target: self, action: #selector(websiteDidTap))
        //label.attributedText = NSAttributedString(string: websiteLabel.text ?? "", attributes: [.kern: 0.24])
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(websiteDidTap)
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .yaWhite
        addProfileImage()
        addUsernameLabel()
        addDescriptionLabel()
        addWebsiteLabel()
        addcategoryTableView()
        mockDataForProfile()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func websiteDidTap(_ sender: UITapGestureRecognizer) {
        print("тап по кнопке")
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
    
    /*
     profileImage.snp.makeConstraints { make in
     make.height.equalTo(70)
     make.width.equalTo(70)
     make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
     make.leading.equalTo(snp.leading).offset(16)
     }
     
     usernameLabel.snp.makeConstraints { make in
     make.top.equalTo(profileImage.snp.top).offset(21)
     make.leading.equalTo(profileImage.snp.trailing).offset(16)
     }
     
     descriptionLabel.snp.makeConstraints { make in
     make.top.equalTo(profileImage.snp.bottom).offset(20)
     make.height.equalTo(72)
     make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(16)
     make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-16)
     }
     
     websiteLabel.snp.makeConstraints { make in
     make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
     make.leading.equalTo(descriptionLabel.snp.leading)
     }
     
     categoryTableView.snp.makeConstraints { make in
     make.top.equalTo(websiteLabel.snp.bottom).offset(40)
     make.height.equalTo(54 * 3)
     make.leading.equalTo(self.snp.leading)
     make.trailing.equalTo(self.snp.trailing)
     }
     */
    
    func mockDataForProfile() {
        profileImage.image = UIImage(named: "Profile")
        usernameLabel.text = "Ann Goncharova"
        descriptionLabel.text = "Грызу гранит приложениестроительства, сейчас живу в Москве, люблю животных, от бейглов тоже не откажусь. В моей коллекции нет ни одного NFT, о чем ни капли не жалею."
        websiteLabel.text = "https://thecode.media/oldskool/"
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
        return cell
    }
    
    // высота строки ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

extension ProfileView: UITableViewDelegate {
    
}
