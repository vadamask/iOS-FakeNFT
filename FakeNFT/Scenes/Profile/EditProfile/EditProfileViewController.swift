//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 13.11.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {
    private let viewModel: EditProfileViewModelProtocol
    private weak var delegate: ProfileUpdateDelegate?
    // кнопка закрыть
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.closeButton.image, for: .normal)
        button.tintColor = .textPrimary
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // фотка профиля
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.profile.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // надпись поверх фото "Сменить фото"
    private lazy var changeAvatarLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.changePhoto // сменить фото
        label.font = .caption10
        label.textColor = .textPrimaryInvert
        label.textAlignment = .center
        label.numberOfLines = 2
        label.backgroundColor = .yaBlack.withAlphaComponent(0.6)
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .scaleAspectFill
        label.layer.cornerRadius = 35
        label.layer.masksToBounds = true
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(changeAvatarDidTap(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapAction)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // надпись под фото "Загрузить изображение"
    private lazy var avatarUpdateURLLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyRegular17
        label.text = L10n.Profile.loadPicture // загрузить изображение
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.backgroundColor = .screenBackground
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // лейбл "Имя"
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .headline22
        label.textColor = .textPrimary
        label.attributedText = NSAttributedString(string: L10n.Profile.username, attributes: [.kern: 0.35])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // поле для редактирования юзернейма
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .bodyRegular17
        textField.textColor = .textPrimary
        textField.backgroundColor = .placeholderBackground
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 12
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    // лейбл "Описание"
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .headline22
        label.textColor = .textPrimary
        label.attributedText = NSAttributedString(string: L10n.Profile.description, attributes: [.kern: 0.35])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // поле редактирования текста описания
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .bodyRegular17
        textView.textColor = .textPrimary
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 5, bottom: 11, right: 16)
        textView.backgroundColor = .placeholderBackground
        textView.layer.cornerRadius = 12
        textView.layer.masksToBounds = true
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    // лейбл "Сайт"
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: L10n.Profile.website, attributes: [.kern: 0.35])
        label.font = .headline22
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // поле редактирования веб-сайта
    private lazy var websiteTextField: UITextField = {
        let textField = UITextField()
        textField.font = .bodyRegular17
        textField.textColor = .textPrimary
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .placeholderBackground
        textField.clearButtonMode = .whileEditing
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(viewModel: EditProfileViewModelProtocol, delegate: ProfileUpdateDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        getData()

        view.backgroundColor = .screenBackground
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.update()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view != descriptionTextView &&
                touch.view != nameTextField &&
                touch.view != websiteTextField {
                descriptionTextView.resignFirstResponder()
                nameTextField.resignFirstResponder()
                websiteTextField.resignFirstResponder()
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    @objc private func closeDidTap(_ sender: UITapGestureRecognizer) {
        guard
            let name = nameTextField.text,
            !name.isEmpty,
            let stringUrl = avatarUpdateURLLabel.text,
            !stringUrl.isEmpty,
            let description = descriptionTextView.text,
            !description.isEmpty,
            let website = websiteTextField.text,
            !website.isEmpty
        else { return }
        
        viewModel.updateProfile(profile: ProfileModel(
            name: name,
            avatar: stringUrl,
            description: description,
            website: website,
            nfts: viewModel.profile?.nfts ?? [],
            likes: viewModel.profile?.likes ?? [],
            id: viewModel.profile?.id ?? ""
        ))
        self.dismiss(animated: true)
    }
    
    @objc private func changeAvatarDidTap(_ sender: UITapGestureRecognizer) {
        avatarUpdateURLLabel.isHidden = false
        let alert = UIAlertController(
            title: "Загрузить изображение",
            message: "Укажите ссылку на аватар",
            preferredStyle: .alert
        )
        
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "Введите ссылку: "
        })
        
        alert.addAction(UIAlertAction(
            title: "Ок",
            style: .default,
            handler: { [weak self] _ in
                guard
                    let self = self,
                    let textField = alert.textFields?[0],
                    let updateURL = textField.text
                else { return }
                
                if checkURL(urlString: updateURL) {
                    self.avatarUpdateURLLabel.text = updateURL
                } else {
                    let wrongURLAlert = UIAlertController(
                        title: "Неверная ссылка",
                        message: "Проверьте формат ссылки",
                        preferredStyle: .alert)
                    wrongURLAlert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { _ in
                        wrongURLAlert.dismiss(animated: true)
                    }))
                    self.present(wrongURLAlert, animated: true)
                }
                alert.dismiss(animated: true)
            })
        )
        self.present(alert, animated: true)
    }
    
    private func checkURL(urlString: String?) -> Bool {
        if let urlString = urlString,
           let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    private func getData() {
        avatarImage.loadImage(
            urlString: viewModel.profile?.avatar,
            placeholder: Asset.profile.image,
            radius: 35)
        avatarUpdateURLLabel.text = viewModel.profile?.avatar
        nameTextField.text = viewModel.profile?.name
        descriptionTextView.text = viewModel.profile?.description
        websiteTextField.text = viewModel.profile?.website
    }
    
    private func setupConstraints() {
        [closeButton,
         avatarImage,
         changeAvatarLabel,
         avatarUpdateURLLabel,
         nameLabel,
         nameTextField,
         descriptionLabel,
         descriptionTextView,
         websiteLabel,
         websiteTextField
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // кнопка закрыть
            closeButton.heightAnchor.constraint(equalToConstant: 42),
            closeButton.widthAnchor.constraint(equalToConstant: 42),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            // аватарка профиля
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 94),
            avatarImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            // смена аватарки
            changeAvatarLabel.heightAnchor.constraint(equalTo: avatarImage.heightAnchor),
            changeAvatarLabel.widthAnchor.constraint(equalTo: avatarImage.widthAnchor),
            changeAvatarLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            changeAvatarLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            // лейбл "Загрузить изображение"
            avatarUpdateURLLabel.topAnchor.constraint(equalTo: changeAvatarLabel.bottomAnchor, constant: 4),
            avatarUpdateURLLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarUpdateURLLabel.heightAnchor.constraint(equalToConstant: 44),
            avatarUpdateURLLabel.widthAnchor.constraint(equalToConstant: 250),
            // лейбл "Имя"
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            // поле для редактирования юзернейма
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.heightAnchor.constraint(equalToConstant: 46),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            // лейбл "Описание"
            descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 22),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            // поле редактирования текста описания
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 132),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            // лейбл "Сайт"
            websiteLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 24),
            websiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            // поле редактирования веб-сайта
            websiteTextField.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 8),
            websiteTextField.heightAnchor.constraint(equalToConstant: 46),
            websiteTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            websiteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension EditProfileViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
