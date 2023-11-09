import UIKit

final class TabBarController: UITabBarController {
    private var servicesAssembly: ServicesAssembly

    private let catalogTabBarItem = UITabBarItem(
        title: L10n.Tab.catalog,
        image: Asset.catalog.image,
        tag: 0
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

        // Catalog
        let catalogViewModel = CatalogViewModel(service: servicesAssembly.nftService)
        let catalogViewController = CatalogViewController(
            viewModel: catalogViewModel
        )
        catalogViewController.tabBarItem = catalogTabBarItem
        let catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
        viewControllers = [catalogNavigationController]

        view.backgroundColor = .screenBackground
    }
}
