//
//  CollectionViewModelSpy.swift
//  FakeNFTTests
//
//  Created by Виктор on 24.11.2023.
//

@testable import FakeNFT
import Foundation
import Combine

final class CollectionViewModelSpy: CollectionViewModelProtocol {
    var state = CurrentValueSubject<FakeNFT.CollectionViewState, Never>(.initial)
    var cellViewModels: [FakeNFT.CollectionCellViewModel] = []
    var headerViewModel: FakeNFT.CollectionHeaderViewModel?
    
    func loadCollection() {
        state.value = .loading
    }
    
    func likeNftWith(id: String, isLiked: Bool) {}
    func addToCartNftWith(id: String) {}
    func removeFromCartNftWith(id: String) {}
    func navigateToAuthorPage(url: URL) {}
    func navigateToNftPageWith(id: String) {}
}
