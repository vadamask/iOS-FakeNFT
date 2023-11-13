import UIKit

private func addSubview() {
    self.addSubview(closeButton)
    self.addSubview(profileImage)
    self.addSubview(editProfileImageLabel)
    self.addSubview(usernameLabel)
    self.addSubview(nameTextField)
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

