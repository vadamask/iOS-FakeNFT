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

        // MARK: Cart
        
        let cartNavigationController = UINavigationController()
        let cartCoordinator = CartCoordinator(navigationController: cartNavigationController)
        cartCoordinator.parentCoordinator = self
        
        let cartTabBarItem = UITabBarItem(
            title: L10n.Tab.cart,
            image: Asset.cart.image,
            tag: 1
        )
        cartNavigationController.tabBarItem = cartTabBarItem
        
        // MARK: Statistics

        let statisticsNavigationController = UINavigationController()
        let statisticsCoordinator = StatisticsCoordinator(navigationController: statisticsNavigationController)
        statisticsCoordinator.parentCoordinator = self

        let statisticsTabBarItem = UITabBarItem(
            title: L10n.Tab.statistics,
            image: Asset.statistics.image,
            tag: 2
        )
        statisticsNavigationController.tabBarItem = statisticsTabBarItem

        tabBarController.viewControllers = [
            catalogNavigationController,
            cartNavigationController,
            statisticsNavigationController
        ]
        tabBarController.selectedIndex = 0

        navigationController.pushViewController(tabBarController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)

        parentCoordinator?.children.append(catalogCoordinator)
        parentCoordinator?.children.append(cartCoordinator)
        parentCoordinator?.children.append(statisticsCoordinator)

        catalogCoordinator.start()
        statisticsCoordinator.start()
        cartCoordinator.start()
    }
}
