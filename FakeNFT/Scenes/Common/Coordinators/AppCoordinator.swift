//
//  AppCoordinator.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 17.11.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.parentCoordinator = self
        children.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
