import ProgressHUD
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    let servicesAssembly = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(windowScene: scene)
        let mainTabBarController = TabBarController(servicesAssembly: servicesAssembly)
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
        
        setupHUD()
    }
    
    private func setupHUD() {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorBackground = .placeholderBackground
        ProgressHUD.colorAnimation = .yaGray
    }
}
