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
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // фотка профиля
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.profile.image
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // надпись поверх фото "Сменить фото"
    private lazy var editProfileImageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .screenBackground.withAlphaComponent(0.6)
        label.text = L10n.Profile.changePhoto
        label.font = .caption10
        label.textColor = .textPrimaryInvert // white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.cornerRadius = 35
        label.layer.masksToBounds = true
        let tapAction = UITapGestureRecognizer(target: self, action:#selector(profileImageDidChange(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapAction)
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
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 41) // установка отступов слева в текст филд
        textField.textRect(forBounds: bounds.inset(by: insets))
        textField.editingRect(forBounds: bounds.inset(by: insets))
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
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
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
        textField.backgroundColor = .placeholderBackground
        textField.clearButtonMode = .whileEditing
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 41) // установка отступов слева в текст филд
        textField.textRect(forBounds: bounds.inset(by: insets))
        textField.editingRect(forBounds: bounds.inset(by: insets))
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
    
    // кнопка закрыть нажата
    @objc
    func closeButtonDidTap(_ sender: UITapGestureRecognizer) {
        viewController?.dismiss(animated: true)
    }
    
    // смена картинки профиля
    @objc
    func profileImageDidChange(_ sender: UITapGestureRecognizer) {
        print("изменено")
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
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}
