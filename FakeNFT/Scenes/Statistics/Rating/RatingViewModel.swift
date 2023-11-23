//
//  RatingViewModel.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import Foundation

struct UserDefaultsKeys {
    static let sortingOrder = "sortingOrder"
}

final class RatingViewModel {
    // MARK: - Properties
    private var networkClient: NetworkClient
    private var users: [User] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?

    // MARK: - Init
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    // MARK: - Data Fetching
    func fetchUsers() {
        showLoading?()

        let request = UsersRequest()
        networkClient.send(request: request, type: [User].self) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideLoading?()

                switch result {
                case .success(let decodedUsers):
                    self?.users = decodedUsers
                    if UserDefaults.standard.string(forKey: UserDefaultsKeys.sortingOrder) == "name" {
                        self?.sortByName()
                    } else {
                        self?.sortByRating()
                    }
                    self?.reloadTableViewClosure?()
                case .failure(let error):
                    print("Error fetching users: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - Methods for TableView
    func getNumberOfRows() -> Int {
        return users.count
    }

    func getUser(at indexPath: IndexPath) -> User {
        return users[indexPath.row]
    }

    // MARK: - Sorting
    func sortByName() {
        users.sort { $0.name.lowercased() < $1.name.lowercased() }
        UserDefaults.standard.set("name", forKey: UserDefaultsKeys.sortingOrder)
    }

    func sortByRating() {
        users.sort {
            guard let rating1 = Int($0.rating), let rating2 = Int($1.rating) else { return false }
            return rating1 > rating2
        }
        UserDefaults.standard.set("rating", forKey: UserDefaultsKeys.sortingOrder)
    }
}
