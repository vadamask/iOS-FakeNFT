import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = .tabInactive
        tabBar.tintColor = .tabActive
        view.backgroundColor = .screenBackground
    }
}
