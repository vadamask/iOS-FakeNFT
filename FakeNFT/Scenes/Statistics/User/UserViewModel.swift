//
//  UserViewModel.swift
//  FakeNFT
//
//  Created by Artem Adiev on 09.11.2023.
//

import Foundation

final class UserViewModel {
    weak var navigation: StatisticsUserPageNavigation?
    // MARK: - Properties
    private var networkClient: NetworkClient
    private var userId: String
    private var user: User?
    var userDetailsUpdated: ((User) -> Void)?
    var userDetailsFetchFailed: ((Error) -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?

    // MARK: - Init
    init(networkClient: NetworkClient, userId: String, navigation: StatisticsUserPageNavigation?) {
        self.networkClient = networkClient
        self.userId = userId
        self.navigation = navigation
    }

    // MARK: - Data Fetching
    func fetchUserDetails() {
        showLoading?()

        let request = UserByIdRequest(id: userId)
        networkClient.send(request: request, type: User.self) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading?()

            switch result {
            case .success(let userDetails):
                self.user = userDetails
                self.userDetailsUpdated?(userDetails)
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
                self.userDetailsFetchFailed?(error)
            }
        }
    }

    func navigateToNFTCollection(nftIds: [String]) {
        navigation?.goToNFTCollection(nftIds: nftIds)
    }
}
