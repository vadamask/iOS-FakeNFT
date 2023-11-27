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
        static let ratingSortingKey = "ratingSortingKey"
        static let reviewWorthyActionCount = "reviewWorthyActionCount"
        static let lastReviewRequestAppVersion = "lastReviewRequestAppVersion"
    }

    var isOnBoarded: Bool {
        get {
            return bool(forKey: Keys.isOnBoarded)
        }
        set {
            set(newValue, forKey: Keys.isOnBoarded)
        }
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

    var ratingSortingType: String? {
        get {
            return string(forKey: Keys.ratingSortingKey)
        }
        set {
            set(newValue, forKey: Keys.ratingSortingKey)
        }
    }

    var reviewWorthyActionCount: Int {
        get {
            return integer(forKey: Keys.reviewWorthyActionCount)
        }
        set {
            set(newValue, forKey: Keys.reviewWorthyActionCount)
        }
    }

    var lastReviewRequestAppVersion: String? {
        get {
            return string(forKey: Keys.lastReviewRequestAppVersion)
        }
        set {
            set(newValue, forKey: Keys.lastReviewRequestAppVersion)
        }
    }
}
