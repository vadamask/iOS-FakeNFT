//
//  CollectionCoordinator.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 17.11.2023.
//

import UIKit

protocol CatalogNavigation: AnyObject {
    func goToCollectionWith(id: String)
}

protocol CollectionNavigation: AnyObject {
    func goToAuthorPage(url: URL)
}

class CatalogCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    deinit {
        print("CatalogCoordinator deinit")
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToMainPage()
    }

    func goToMainPage() {
        let viewModel = CatalogViewModel(service: ServicesAssembly.shared.nftService, navigation: self)
        let catalogController = CatalogViewController(viewModel: viewModel, layout: CatalogLayout())
        navigationController.pushViewController(catalogController, animated: true)
    }
}

extension CatalogCoordinator: CatalogNavigation {
    func goToCollectionWith(id: String) {
        let viewModel = CollectionViewModel(
            collectionId: id,
            service: ServicesAssembly.shared.nftService,
            navigation: self
        )
        let collectionController = CollectionViewController(viewModel: viewModel, layout: CollectionLayout())
        collectionController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(collectionController, animated: true)
    }
}

extension CatalogCoordinator: CollectionNavigation {
    func goToAuthorPage(url: URL) {
        let webViewVC = WebViewController(url: url)
        navigationController.pushViewController(webViewVC, animated: true)
    }
}
