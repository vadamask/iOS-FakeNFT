//
//  TabBarCoordinator.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 17.11.2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
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
        
        // profile
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileCoordinator.parentCoordinator = self
        
        // catalog
        
        let catalogNavigationController = UINavigationController()
        let catalogCoordinator = CatalogCoordinator(navigationController: catalogNavigationController)
        catalogCoordinator.parentCoordinator = self
        
        let catalogTabBarItem = UITabBarItem(
            title: L10n.Tab.catalog,
            image: Asset.catalog.image,
            tag: 0
        )
        catalogNavigationController.tabBarItem = catalogTabBarItem
        
        // cart
        
        let cartNavigationController = UINavigationController()
        let cartCoordinator = CartCoordinator(navigationController: cartNavigationController)
        cartCoordinator.parentCoordinator = self
        
        let cartTabBarItem = UITabBarItem(
            title: L10n.Tab.cart,
            image: Asset.cart.image,
            tag: 1
        )
        
        cartNavigationController.tabBarItem = cartTabBarItem
        
        // statistic
        
        let statisticNavigationController = UINavigationController()
        let statisticCoordinator = StatisticCoordinator(navigationController: statisticNavigationController)
        statisticCoordinator.parentCoordinator = self

        tabBarController.viewControllers = [
            profileNavigationController,
            catalogNavigationController,
            cartNavigationController,
            statisticNavigationController
        ]
        tabBarController.selectedIndex = 1
        
        navigationController.pushViewController(tabBarController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)

        parentCoordinator?.children.append(profileCoordinator)
        parentCoordinator?.children.append(catalogCoordinator)
        parentCoordinator?.children.append(cartCoordinator)
        parentCoordinator?.children.append(statisticCoordinator)
        
        profileCoordinator.start()
        catalogCoordinator.start()
        cartCoordinator.start()
        statisticCoordinator.start()
    }
}
