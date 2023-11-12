//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    /*
     private var editButton = UIBarButtonItem(
     image: UIImage(asset: Asset.profile),
     style: .plain,
     target: self,
     action: #selector(didTapEditButton)
     )
     */
    
    private var editButton: UIBarButtonItem?
    
    private var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileViewModel(viewController: self)
        bind()
        setupNavigationBar()
        // viewModel?.viewDidLoad()
        setupView()
    }
    
    @objc
    private func didTapEditButton() {
        print("тап по кнопке")
    }
    
    private func bind() {
        if let viewModel = viewModel {
            viewModel.onChange = { [weak self] in
            //self?.summaryView.configure(with: viewModel.summaryInfo)
            }
        }
    }
    
    func setupView() {
        self.view = ProfileView()
        setupNavBar()
    }
    
    func setupNavigationBar() {
        editButton = UIBarButtonItem(image: UIImage(named: "editButton"), style: .plain, target: self, action: #selector(didTapEditButton))
        editButton?.tintColor = .yaBlack
        guard let editButton = editButton else {return}
        navigationItem.rightBarButtonItem = editButton
    }
    
    
    func setupNavBar() {
        navigationController?.navigationBar.tintColor = .yaBlack
        navigationItem.rightBarButtonItem = editButton
    }
}
