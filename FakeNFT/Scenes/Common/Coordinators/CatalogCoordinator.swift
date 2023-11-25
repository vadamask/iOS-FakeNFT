//
//  CollectionCoordinator.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 17.11.2023.
//

import UIKit

final class CatalogCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let catalogController = TestCatalogViewController(
            servicesAssembly: ServicesAssembly()
        )
        navigationController.pushViewController(catalogController, animated: true)
    }
}
