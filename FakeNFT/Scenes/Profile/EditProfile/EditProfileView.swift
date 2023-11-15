//
//  EditProfileView.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 13.11.2023.
//

import Kingfisher
import UIKit

final class EditProfileView: UIView {
    private var viewController: EditProfileViewController?
    // кнопка закрыть
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.closeButton.image, for: .normal)
        button.tintColor = .textPrimary
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // фотка профиля
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.profile.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // надпись поверх фото "Сменить фото"
    private lazy var editProfileImageLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.changePhoto
        label.font = .caption10
        label.textColor = .textPrimaryInvert
        label.textAlignment = .center
        label.numberOfLines = 0
        label.contentMode = .scaleAspectFill
        label.layer.cornerRadius = 35
        label.layer.masksToBounds = true
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(profileImageDidChange(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapAction)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // надпись под фото "Загрузить изображение"
    private lazy var loadProfileImage: UILabel = {
        let label = UILabel()
        label.font = .bodyRegular17
        label.text = L10n.Profile.loadPicture
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
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .headline22
        label.textColor = .textPrimary // black
        label.attributedText = NSAttributedString(string: "Имя", attributes: [.kern: 0.35])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // поле для редактирования юзернейма
    private lazy var usernameTextField: UITextField = {
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
        label.textColor = .textPrimary // black
        label.attributedText = NSAttributedString(string: "Описание", attributes: [.kern: 0.35])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // поле редактирования текста описания
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .bodyRegular17
        textView.textColor = .textPrimary // black
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
        label.attributedText = NSAttributedString(string: "Сайт", attributes: [.kern: 0.35])
        label.font = .headline22
        label.textColor = .textPrimary // black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // поле редактирования веб-сайта
    private lazy var websiteTextField: UITextField = {
        let textField = UITextField()
        textField.font = .bodyRegular17
        textField.textColor = .textPrimary // black
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
    
    init(frame: CGRect, viewController: EditProfileViewController) {
        super.init(frame: .zero)
        self.viewController = viewController
        self.backgroundColor = .screenBackground
        addSubview()
        setupConstraints()
        getDataFromViewModel()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // скрытие клавиатуры
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    func getDataFromViewModel() {
        guard let viewModel = viewController?.viewModel else { return }
        profileImage.kf.setImage(
            with: viewModel.avatarURL,
            placeholder: Asset.profile.image,
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 35))])
            usernameTextField.text = viewModel.name
            descriptionTextView.text = viewModel.description
            websiteTextField.text = viewModel.website
    }
    
    // кнопка закрыть нажата
    @objc
    func closeButtonDidTap(_ sender: UITapGestureRecognizer) {
        guard let viewModel = viewController?.viewModel,
              let name = usernameTextField.text, name != "",
              let description = descriptionTextView.text, description != "",
              let website = websiteTextField.text, website != "",
              let likes = viewModel.likes else { return }
        
        viewModel.putProfileData(
            name: name,
            description: description,
            website: website,
            likes: likes
        )
        viewController?.dismiss(animated: true)
    }
    
    // смена картинки профиля
    @objc
    func profileImageDidChange(_ sender: UITapGestureRecognizer) {
        loadProfileImage.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view != descriptionTextView &&
                touch.view != usernameTextField &&
                touch.view != websiteTextField {
                descriptionTextView.resignFirstResponder()
                usernameTextField.resignFirstResponder()
                websiteTextField.resignFirstResponder()
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    private func addSubview() {
        self.addSubview(closeButton)
        self.addSubview(profileImage)
        self.addSubview(editProfileImageLabel)
        self.addSubview(usernameLabel)
        self.addSubview(usernameTextField)
        self.addSubview(descriptionLabel)
        self.addSubview(descriptionTextView)
        self.addSubview(websiteLabel)
        self.addSubview(websiteTextField)
        self.addSubview(loadProfileImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // кнопка закрыть
            closeButton.heightAnchor.constraint(equalToConstant: 42),
            closeButton.widthAnchor.constraint(equalToConstant: 42),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // аватарка профиля
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 94),
            profileImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            // смена аватарки
            editProfileImageLabel.heightAnchor.constraint(equalToConstant: 70),
            editProfileImageLabel.widthAnchor.constraint(equalToConstant: 70),
            editProfileImageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 94),
            editProfileImageLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            // лейбл "Загрузить изображение"
            loadProfileImage.topAnchor.constraint(equalTo: editProfileImageLabel.bottomAnchor, constant: 4),
            loadProfileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadProfileImage.heightAnchor.constraint(equalToConstant: 44),
            loadProfileImage.widthAnchor.constraint(equalToConstant: 250),
            
            // лейбл "Имя"
            usernameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 24),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // поле для редактирования юзернейма
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            usernameTextField.heightAnchor.constraint(equalToConstant: 46),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // лейбл "Описание"
            descriptionLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 22),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // поле редактирования текста описания
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 132),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // лейбл "Сайт"
            websiteLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 24),
            websiteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // поле редактирования веб-сайта
            websiteTextField.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 8),
            websiteTextField.heightAnchor.constraint(equalToConstant: 46),
            websiteTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            websiteTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

extension EditProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditProfileView: UITextViewDelegate {
    }
