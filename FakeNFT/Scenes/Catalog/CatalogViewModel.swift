//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Виктор on 05.11.2023.
//

import Foundation

final class CatalogViewModel {
    @Observable private(set) var cellViewModels: [CatalogCellViewModel]?
    func viewDidLoaded() {
        var mockCells: [CatalogCellViewModel]? = []
        for i in 0...10 {
            mockCells?.append(CatalogCellViewModel(image: Asset.pinkCover.image, labelText: "Test label (\(i))"))
        }
        cellViewModels = mockCells
    }
}
