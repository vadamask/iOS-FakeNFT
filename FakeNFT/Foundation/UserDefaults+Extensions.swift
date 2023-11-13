//
//  UserDefaults+Extensions.swift
//  FakeNFT
//
//  Created by Виктор on 09.11.2023.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let sortingKey = "sortingKey"
    }
    var sortingType: CatalogViewModelSortingType {
        get {
            let rawValue = integer(forKey: Keys.sortingKey)
            return CatalogViewModelSortingType(rawValue: rawValue) ?? .byNameAsc
        }
        set {
            set(newValue.rawValue, forKey: Keys.sortingKey)
        }
    }
}
