//
//  RatingViewModel.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import Foundation

final class RatingViewModel {
    // MARK: - Properties
    private var networkClient: NetworkClient
    private var users: [Users] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (() -> Void)?

    // MARK: - Initialization
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    // MARK: - Data Fetching
    func fetchUsers() {
        let request = UsersRequest()
        networkClient.send(request: request, type: [Users].self) { [weak self] result in
            // Лучше все действия с UI производить в контроллере, в том числе и DispatchQueue.main.async { }
            // TODO: Изучить варианты
            DispatchQueue.main.async {
                switch result {
                case .success(let decodedUsers):
                    self?.users = decodedUsers
                    self?.sortByRating()
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

    func getUser(at indexPath: IndexPath) -> Users {
        return users[indexPath.row]
    }

    // MARK: - Sorting
    func sortByName() {
        users.sort { $0.name.lowercased() < $1.name.lowercased()
        }
    }

    func sortByRating() {
        users.sort {
            guard let rating1 = Int($0.rating), let rating2 = Int($1.rating) else { return false }
            return rating1 > rating2
        }
    }
}
