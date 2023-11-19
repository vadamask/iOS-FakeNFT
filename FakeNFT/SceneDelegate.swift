import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

//    let servicesAssembly = ServicesAssembly(
//        networkClient: DefaultNetworkClient(),
//        nftStorage: NftStorageImpl()
//    )

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(windowScene: scene)
        let mainTabBarController = TabBarController()
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
    }
}
