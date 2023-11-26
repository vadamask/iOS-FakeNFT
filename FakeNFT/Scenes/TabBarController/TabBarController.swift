import UIKit

final class TabBarController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureController()
    }
    
    private func createMockViewController(
        title: String,
        backgroundColor: UIColor
    ) -> UIViewController {
        let vc = UIViewController()
        vc.title = title
        vc.view.backgroundColor = backgroundColor
        return vc
    }
    
    private func configureController() {
        let firstMockVc = createMockViewController(
            title: "1-st mock vc",
            backgroundColor: .screenBackground
        )
        
        let thirdMockVc = createMockViewController(
            title: "3-rd mock vc",
            backgroundColor: .screenBackground
        )
        let forthMockVc = createMockViewController(
            title: "4-th mock vc",
            backgroundColor: .screenBackground
        )
        
        tabBar.backgroundColor = .screenBackground
        
        let profileNavigationController = NavigationController(
            rootViewController: ProfileViewController(viewModel: ProfileViewModel())
        )
        let cartNavigationController = NavigationController(
            rootViewController: thirdMockVc
        )
        let statisticsNavigationController = NavigationController(
            rootViewController: forthMockVc
        )
        
        let catalogueNavigationController = NFTsFactory.create()
        
        self.viewControllers = [
            configureTab(
                controller: profileNavigationController,
                title: "Профиль", // добавить локаль
                image: Asset.profile.image
            )
        ]
    }
    
    private func configureTab(
        controller: UIViewController,
        title: String? = nil,
        image: UIImage
    ) -> UIViewController {
        let tab = controller
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        tab.tabBarItem = tabBarItem
        return tab
    }
}
