//
//  TabBarCoordinator.swift
//  FakeNFT
//
//  Created by Виктор on 21.11.2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    deinit {
        print("TabBarCoordinator deinit")
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        initializeTabBar()
    }

    private func initializeTabBar() {
        let tabBarController = TabBarController()

        // MARK: Catalog

        let catalogNavigationController = UINavigationController()
        let catalogCoordinator = CatalogCoordinator(navigationController: catalogNavigationController)
        catalogCoordinator.parentCoordinator = self

        let catalogTabBarItem = UITabBarItem(
            title: L10n.Tab.catalog,
            image: Asset.catalog.image,
            tag: 0
        )
        catalogNavigationController.tabBarItem = catalogTabBarItem

        tabBarController.viewControllers = [
            catalogNavigationController
        ]
        tabBarController.selectedIndex = 0

        navigationController.pushViewController(tabBarController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)

        parentCoordinator?.children.append(catalogCoordinator)

        catalogCoordinator.start()
    }
}
