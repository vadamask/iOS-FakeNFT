//
//  NFTsFactory.swift
//  FakeNFT
//
//  Created by Anka on 23.11.2023.
//

import UIKit
// навигация между вью контроллерами
struct NFTsFactory {
    static func create() -> UINavigationController {
        let model = NFTsViewModelImpl()
        let vc = NFTsViewController(viewModel: model)
        return UINavigationController(rootViewController: vc)
    }
}
