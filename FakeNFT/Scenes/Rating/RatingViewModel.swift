//
//  RatingViewModel.swift
//  FakeNFT
//
//  Created by Artem Adiev on 05.11.2023.
//

import Foundation

class RatingViewModel {
    // MARK: - Properties
    // Массив с пользователями
    private var users: [Users] = [] {
        // При изменении свойства обновляем UI
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    // Замыкание, которое вызываем для обновления UI после получения данных
    var reloadTableViewClosure: (() -> Void)?

    // MARK: - Initialization
    init() {
    }

    // MARK: - Data Fetching
    // Получаем пользователей из сети
    func fetchUsers() {
        // TODO: Прописать URL в Services\Requests
        let urlString = "\(RequestConstants.baseURL)/api/v1/users"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }
            // Проверка наличия данных
            guard let data = data else {
                print("No data received.")
                return
            }
            // Вытаскиваем данные
            do {
                // Декодирование полученных данных в массив структур Users
                let decodedUsers = try JSONDecoder().decode([Users].self, from: data)
                // Сохраняем декодированные данные в свойство users
                self.users = decodedUsers
                // Сортируем пользователей по рейтингу
                self.sortByRating()
                // Обновляем UI в главном потоке
                DispatchQueue.main.async {
                    self.reloadTableViewClosure?()
                }
            } catch {
                // Обрабатываем ошибки
                print("Error decoding users: \(error.localizedDescription)")
            }
        }.resume()
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
