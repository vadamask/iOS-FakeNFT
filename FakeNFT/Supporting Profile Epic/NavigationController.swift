//
//  NavigationController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 21.11.2023.
//

import UIKit

protocol EditProfileButtonDelegate: AnyObject {
    func proceedToEditing()
}

final class NavigationController: UINavigationController {
    var editProfileButtonDelegate: EditProfileButtonDelegate?
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationController(forVC: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NavigationController: init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func editTapped() {
        editProfileButtonDelegate?.proceedToEditing()
    }
    
    private func configureNavigationController(forVC viewController: UIViewController) {
        navigationBar.tintColor = .yaBlack
        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .foregroundColor: UIColor.yaBlack
        ]
        
        if viewController is ProfileViewController {
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
                image: Asset.editButton.image,
                style: .done,
                target: nil,
                action: #selector(editTapped)
            )
        }
    }
}
