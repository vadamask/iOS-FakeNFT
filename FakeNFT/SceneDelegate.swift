import ProgressHUD
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        setupHUD()
    }
    
    private func setupHUD() {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorBackground = .placeholderBackground
        ProgressHUD.colorAnimation = .yaGray
    }
}
