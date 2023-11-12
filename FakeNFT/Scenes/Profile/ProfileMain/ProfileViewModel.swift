//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

final class ProfileViewModel {
    var onChange: (() -> Void)?
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
