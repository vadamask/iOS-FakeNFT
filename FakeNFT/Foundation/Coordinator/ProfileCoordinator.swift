import UIKit

final class ProfileCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileViewModel = ProfileViewModel(
            coordinator: self
        )
        
        let profileController = ProfileViewController(viewModel: profileViewModel)
        navigationController.pushViewController(profileController, animated: true)
    }
}
