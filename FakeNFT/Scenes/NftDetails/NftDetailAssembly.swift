import UIKit

public final class NftDetailAssembly {
    private let servicesAssembler: ServicesAssemblyProtocol

    init(servicesAssembler: ServicesAssemblyProtocol) {
        self.servicesAssembler = servicesAssembler
    }

    public func build(with input: NftDetailInput) -> UIViewController {
        let presenter = NftDetailPresenterImpl(
            input: input,
            service: servicesAssembler.nftService
        )
        let viewController = NftDetailViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
