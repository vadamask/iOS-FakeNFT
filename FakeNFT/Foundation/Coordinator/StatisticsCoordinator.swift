//
//  StatisticsCoordinator.swift
//  FakeNFT
//
//  Created by Виктор on 27.11.2023.
//

import UIKit

protocol StatisticsNavigation: AnyObject {
    func goToUserPage(userId: String)
}

protocol StatisticsUserPageNavigation: AnyObject {
    func goToNFTCollection(nftIds: [String])
}

final class StatisticsCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToMainPage()
    }

    func goToMainPage() {
        let viewModel = RatingViewModel(networkClient: DefaultNetworkClient(), navigation: self)
        let ratingController = RatingViewController(viewModel: viewModel)
        navigationController.pushViewController(ratingController, animated: true)
    }
}

extension StatisticsCoordinator: StatisticsNavigation {
    func goToUserPage(userId: String) {
        let userVC = UserViewController(userId: userId, navigation: self)
        userVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(userVC, animated: true)
    }
}

extension StatisticsCoordinator: StatisticsUserPageNavigation {
    func goToNFTCollection(nftIds: [String]) {
        let collectionVC = NFTCollectionViewController(nftIds: nftIds)
        navigationController.pushViewController(collectionVC, animated: true)
    }
}
