//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var editButton: UIBarButtonItem!
    /*
    (
        image: Asset.editButton.image,
        style: .plain,
        target: self,
        action: #selector(didTapEditButton)
    )
     */
    
    private var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel(viewController: self)
        bind()
        setupView()
        setupNavBar()
    }
    
    @objc
    private func didTapEditButton() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.viewModel = viewModel
        editProfileViewController.modalPresentationStyle = .popover
        self.present(editProfileViewController, animated: true)
    }
    
    private func bind() {
        if let viewModel = viewModel {
            viewModel.onChange = { [weak self] in
                let view = self?.view as? ProfileView
                view?.updateViews(
                    avatarURL: viewModel.avatarURL,
                    userName: viewModel.name,
                    description: viewModel.description,
                    website: viewModel.website,
                    nftCount: "(\(String(viewModel.nfts?.count ?? 0)))",
                    likesCount: "(\(String(viewModel.likes?.count ?? 0)))"
                )
            }
        }
    }
    
    func setupView() {
        self.view = ProfileView(frame: .zero, viewController: self)
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.tintColor = .yaBlack
        editButton = UIBarButtonItem(
                image: Asset.editButton.image,
                style: .plain,
                target: self,
                action: #selector(didTapEditButton)
            )
        navigationItem.rightBarButtonItem = editButton
        
    }
}
