//
//  UserDefaults+Extensions.swift
//  FakeNFT
//
//  Created by Виктор on 09.11.2023.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let isOnBoarded = "isOnBoarded"
        static let catalogSortingKey = "catalogSortingKey"
    }
    var catalogSortingType: CatalogViewModelSortingType {
        get {
            let rawValue = integer(forKey: Keys.catalogSortingKey)
            return CatalogViewModelSortingType(rawValue: rawValue) ?? .byNameAsc
        }
        set {
            set(newValue.rawValue, forKey: Keys.catalogSortingKey)
        }
    }
    var isOnBoarded: Bool {
        get {
            return bool(forKey: Keys.isOnBoarded)
        }
        set {
            set(newValue, forKey: Keys.isOnBoarded)
        }
    }
}
