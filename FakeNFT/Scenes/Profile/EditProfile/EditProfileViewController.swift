//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 13.11.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = EditProfileView(frame: .zero, viewController: self)
    }
}
