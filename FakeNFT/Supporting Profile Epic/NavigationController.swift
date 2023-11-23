//
//  NavigationController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 21.11.2023.
//

import UIKit
final class NavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NavigationController: init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configureNavigationController() {
        navigationBar.tintColor = .yaBlack
        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .foregroundColor: UIColor.yaBlack
        ]
    }
}
