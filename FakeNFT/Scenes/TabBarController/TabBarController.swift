import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .black
        
        let profileViewModel = ProfileViewModel(networkClient: nil)
        let profileViewController = UINavigationController(
            rootViewController: ProfileViewController(viewModel: profileViewModel)
        )
        
        let statisticsViewController = UINavigationController(
            rootViewController: UIViewController()
        )
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: Asset.profile.image,
            selectedImage: nil
        )

        let controllers = [
            profileViewController,
        ]
        
        viewControllers = controllers
    }
}
