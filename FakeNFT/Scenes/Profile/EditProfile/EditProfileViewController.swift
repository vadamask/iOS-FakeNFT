//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 13.11.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = EditProfileView(frame: .zero, viewController: self)
    }
}
