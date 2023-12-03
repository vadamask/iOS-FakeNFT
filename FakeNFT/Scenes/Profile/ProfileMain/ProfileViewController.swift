//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    private var profileView: ProfileView?
    private var viewModel: ProfileViewModelProtocol
    private var badConnection = false
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.editButton.image,
            style: .plain,
            target: self,
            action: #selector(didTapEditButton))
        button.tintColor = .borderColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = profileView
        setupNavBar()
        bind()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if badConnection { viewModel.getProfileData() }
        viewModel.getProfileData()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.profileView = ProfileView(frame: .zero, viewModel: self.viewModel, viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapEditButton() {
        let editProfileViewController = EditProfileViewController(viewModel: viewModel)
        editProfileViewController.modalPresentationStyle = .popover
        self.present(editProfileViewController, animated: true)
    }
    
    private func bind() {
        viewModel.onChange = { [weak self] in
            self?.badConnection = false
            
            self?.profileView?.updateViews(
                avatarURL: self?.viewModel.avatarURL,
                userName: self?.viewModel.name,
                description: self?.viewModel.description,
                website: self?.viewModel.website,
                nftCount: "(\(String(self?.viewModel.nfts?.count ?? 0)))",
                likesCount: "(\(String(self?.viewModel.likes?.count ?? 0)))"
            )
        }
        
        viewModel.onError = { [weak self] in
            self?.badConnection = true
            self?.view = NoInternetView()
            self?.navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .screenBackground
        navigationItem.rightBarButtonItem = editButton
        self.navigationController?.navigationBar.isHidden = false
    }
}
