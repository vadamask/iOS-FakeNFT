//
//  File.swift
//  FakeNFTTests
//
//  Created by Виктор on 24.11.2023.
//

@testable import FakeNFT
import XCTest
import Combine

final class CatalogViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func testViewModelLoadCollectionsCalled() throws {
        let viewModel = CatalogViewModelSpy()
        let vController = CatalogViewController(viewModel: viewModel, layout: CatalogLayout())
        _ = vController.view
        if case .loading = viewModel.state.value {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testViewModelLoadCollectionsState() throws {
        var testedState: CatalogViewModelState = .initial
        let expectation = XCTestExpectation(description: "Get async data.")
        let service = NftServiceStub()
        let viewModel = CatalogViewModel(service: service, navigation: nil)
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
        viewModel.loadCollections()
        wait(for: [expectation], timeout: 5)
        if case .loading = testedState {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

    func testViewModelRefreshCollectionsState() throws {
        var testedState: CatalogViewModelState = .initial
        let expectation = XCTestExpectation(description: "Get async data.")
        let service = NftServiceStub()
        let viewModel = CatalogViewModel(service: service, navigation: nil)
        viewModel.state
            .first {
                if case .refreshing = $0 {
                    return true
                }
                return false
            }
            .sink { state in
                if case .refreshing = state {
                    testedState = state
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.refreshCollections()
        wait(for: [expectation], timeout: 5)
        if case .refreshing = testedState {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

    func testViewModelFetchCollections() throws {
        var testedState: CatalogViewModelState = .initial
        let expectation = XCTestExpectation(description: "Get async data.")
        let service = NftServiceStub()
        let viewModel = CatalogViewModel(service: service, navigation: nil)
        viewModel.state
            .sink { state in
                if case .ready = state {
                    testedState = state
                    expectation.fulfill()
                } else if case .error = state {
                    testedState = state
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.loadCollections()
        wait(for: [expectation], timeout: 5)
        if case .ready = testedState {
            XCTAssert(true)
            XCTAssertEqual(viewModel.cellViewModels.count, 3)
            XCTAssert(viewModel.cellViewModels.contains { $0.name == "Beige" })
            XCTAssert(viewModel.cellViewModels.contains { $0.name == "Blue" })
            XCTAssert(viewModel.cellViewModels.contains { $0.name == "Gray" })
            XCTAssert(viewModel.cellViewModels.first { $0.id == "2" }?.nftCount == 5)
            XCTAssertNotNil(viewModel.cellViewModels[0].coverUrl)
        } else {
            XCTAssert(false)
        }
    }

    func testViewModelSortingCollections() throws {
        UserDefaults.standard.catalogSortingType = .byNftCountDesc
        var sortingType = UserDefaults.standard.catalogSortingType
        var testedState: CatalogViewModelState = .initial
        let expectation1 = XCTestExpectation(description: "Sorting byNftCountDesc data.")
        let expectation2 = XCTestExpectation(description: "Sorting byNameAsc data.")
        let service = NftServiceStub()
        let viewModel = CatalogViewModel(service: service, navigation: nil)
        viewModel.state
            .sink { state in
                if case .ready = state {
                    testedState = state
                    switch sortingType {
                    case .byNftCountDesc:
                        expectation1.fulfill()
                    case .byNameAsc:
                        expectation2.fulfill()
                    case .byNameDesc, .byNftCountAsc: break
                    }
                } else if case .error = state {
                    testedState = state
                    expectation1.fulfill()
                    expectation2.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.loadCollections()
        wait(for: [expectation1], timeout: 5)
        if case .ready = testedState {
            XCTAssert(true)
            XCTAssertEqual(viewModel.cellViewModels.count, 3)
            XCTAssert(viewModel.cellViewModels[0].nftCount > viewModel.cellViewModels[1].nftCount)
            XCTAssert(viewModel.cellViewModels[1].nftCount > viewModel.cellViewModels[2].nftCount)
        } else {
            XCTAssert(false)
        }

        sortingType = .byNameAsc
        viewModel.changeSorting(to: sortingType)
        wait(for: [expectation2], timeout: 5)
        if case .ready = testedState {
            XCTAssert(true)
            XCTAssertEqual(viewModel.cellViewModels.count, 3)
            XCTAssert(viewModel.cellViewModels[0].name < viewModel.cellViewModels[1].name)
            XCTAssert(viewModel.cellViewModels[1].name < viewModel.cellViewModels[2].name)
        } else {
            XCTAssert(false)
        }
    }
}
