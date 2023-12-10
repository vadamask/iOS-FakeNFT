//
//  CollectionViewModelTests.swift
//  FakeNFTTests
//
//  Created by Виктор on 24.11.2023.
//

@testable import FakeNFT
import XCTest
import Combine

final class CollectionViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func testViewModelLoadCollectionCalled() throws {
        let viewModel = CollectionViewModelSpy()
        let vController = CollectionViewController(viewModel: viewModel, layout: CollectionLayout())
        _ = vController.view
        if case .loading = viewModel.state.value {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

    func testViewModelLoadCollectionsState() throws {
        var testedState: CollectionViewState = .initial
        let expectation = XCTestExpectation(description: "Get async data.")
        let service = NftServiceStub()
        let viewModel = CollectionViewModel(collectionId: "0", service: service, navigation: nil)
        viewModel.state
            .first {
                if case .loading = $0 {
                    return true
                }
                return false
            }
            .sink { state in
                if case .loading = state {
                    testedState = state
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.loadCollection()
        wait(for: [expectation], timeout: 5)
        if case .loading = testedState {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

    func testViewModelFetchCollections() throws {
        var testedState: CollectionViewState = .initial
        let expectation = XCTestExpectation(description: "Get async data.")
        let service = NftServiceStub()
        let viewModel = CollectionViewModel(collectionId: "0", service: service, navigation: nil)
        viewModel.state
            .sink { state in
                if case .loaded = state {
                    testedState = state
                    expectation.fulfill()
                } else if case .error = state {
                    testedState = state
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.loadCollection()
        wait(for: [expectation], timeout: 5)
        if case .loaded = testedState {
            XCTAssert(true)
            XCTAssertNotNil(viewModel.headerViewModel?.cover)
            XCTAssertEqual(viewModel.headerViewModel?.name, "Beige")
            XCTAssertEqual(viewModel.headerViewModel?.author, "Elijah Anderson")
            XCTAssertEqual(viewModel.cellViewModels.count, 5)
            XCTAssertEqual(viewModel.cellViewModels[0].name, "April")
            XCTAssertTrue(viewModel.cellViewModels[0].inOrder)
            XCTAssertTrue(viewModel.cellViewModels[0].isLiked)
            XCTAssertFalse(viewModel.cellViewModels[0].name == "Gray")
        } else {
            XCTAssert(false)
        }
    }
}
