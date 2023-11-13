//
//  UserViewModel.swift
//  FakeNFT
//
//  Created by Artem Adiev on 09.11.2023.
//

import Foundation

final class UserViewModel {
    // MARK: - Properties
    private var networkClient: NetworkClient
    private var userId: String
    private var user: User?
    var userDetailsUpdated: ((User) -> Void)?
    var userDetailsFetchFailed: ((Error) -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?

    // MARK: - Init
    init(networkClient: NetworkClient, userId: String) {
        self.networkClient = networkClient
        self.userId = userId
    }

    // MARK: - Data Fetching
    func fetchUserDetails() {
        showLoading?()

        let request = UserByIdRequest(id: userId)
        networkClient.send(request: request, type: User.self) { [weak self] result in
            self?.hideLoading?()

            switch result {
            case .success(let userDetails):
                self?.user = userDetails
                self?.userDetailsUpdated?(userDetails)
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
                self?.userDetailsFetchFailed?(error)
            }
        }
    }
}
