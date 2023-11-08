import UIKit

final class TabBarController: UITabBarController {
    private var servicesAssembly: ServicesAssembly

    private let catalogTabBarItem = UITabBarItem(
        title: L10n.Tab.catalog,
        image: Asset.catalog.image,
        tag: 0
    )

    private let statisticsTabBarItem = UITabBarItem(
        title: L10n.Tab.statistics,
        image: Asset.statistics.image,
        tag: 1
    )

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.unselectedItemTintColor = .tabInactive
        tabBar.tintColor = .tabActive

        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        catalogController.tabBarItem = catalogTabBarItem

        let statisticsController = RatingViewController()
        statisticsController.tabBarItem = statisticsTabBarItem
        let statisticsNavController = UINavigationController(rootViewController: statisticsController)

        viewControllers = [catalogController, statisticsNavController]

        view.backgroundColor = .screenBackground
    }
}
