import UIKit

final class TabBarController: UITabBarController {
    private let catalogTabBarItem = UITabBarItem(
        title: L10n.Tab.catalog,
        image: Asset.catalog.image,
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.unselectedItemTintColor = .tabInactive
        tabBar.tintColor = .tabActive

        // Catalog
        let catalogViewModel = CatalogViewModel(service: ServicesAssembly.shared.nftService)
        let catalogViewController = CatalogViewController(
            viewModel: catalogViewModel,
            layout: CatalogLayout()
        )
        catalogViewController.tabBarItem = catalogTabBarItem
        let catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
        viewControllers = [catalogNavigationController]

        view.backgroundColor = .screenBackground
    }
}
