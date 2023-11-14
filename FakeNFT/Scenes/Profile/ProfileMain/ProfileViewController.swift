//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var editButton = UIBarButtonItem(
        image: Asset.profile.image,
        style: .plain,
        target: self,
        action: #selector(didTapEditButton)
    )
    
    // private var editButton: UIBarButtonItem?
    
    private var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileViewModel(viewController: self)
        bind()
        //setupNavigationBar()
        // viewModel?.viewDidLoad()
        setupView()
    }
    
    @objc
    private func didTapEditButton() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.modalPresentationStyle = .popover
        self.present(editProfileViewController, animated: true)
    }
    
    private func bind() {
        if let viewModel = viewModel {
            viewModel.onChange = { [weak self] in
                let view = self?.view as? ProfileView
                view?.updateViews(
                    userImageURL: viewModel.userImageURL,
                    userName: viewModel.userName,
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
    
    /*
     func setupNavigationBar() {
     editButton = UIBarButtonItem(image: UIImage(named: "editButton"), style: .plain, target: self, action: #selector(didTapEditButton))
     editButton?.tintColor = .yaBlack
     guard let editButton = editButton else {return}
     navigationItem.rightBarButtonItem = editButton
     }
     */
    
    func setupNavBar() {
        navigationController?.navigationBar.tintColor = .yaBlack
        navigationItem.rightBarButtonItem = editButton
    }
}
