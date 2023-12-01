import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .screenBackground
        tabBar.tintColor = .textPrimary
        tabBar.unselectedItemTintColor = .tabInactive
        
        let profileViewModel = ProfileViewModel(networkClient: nil)
        let profileViewController = UINavigationController(
            rootViewController: ProfileViewController(viewModel: profileViewModel)
        )
        
        let statisticsViewController = UINavigationController(
            rootViewController: UIViewController()
        )
        
        profileViewController.tabBarItem = UITabBarItem(
            title: L10n.Tab.profile,
            image: Asset.profile.image,
            selectedImage: nil
        )

        let controllers = [
            profileViewController
        ]
        
        viewControllers = controllers
    }
}
