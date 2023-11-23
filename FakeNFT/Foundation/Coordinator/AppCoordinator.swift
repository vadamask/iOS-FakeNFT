//
//  AppCoordinator.swift
//  FakeNFT
//
//  Created by Виктор on 21.11.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

final class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        UserDefaults.standard.isOnBoarded ? goToHome() : goToOnboarding()
    }

    func goToOnboarding() {
        children.removeAll()
        let onBoarding = OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        onBoarding.coordinator = self
        navigationController.pushViewController(onBoarding, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func goToHome() {
        children.removeAll()
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.parentCoordinator = self
        children.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
