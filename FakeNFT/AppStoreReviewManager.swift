//
//  File.swift
//  FakeNFT
//
//  Created by Виктор on 22.11.2023.
//

import StoreKit

enum AppStoreReviewManager {
    static let minimumReviewWorthyActionCount = 3
    static func requestReviewIfAppropriate() {
        let defaults = UserDefaults.standard
        let bundle = Bundle.main
        var actionCount = defaults.reviewWorthyActionCount
        actionCount += 1
        defaults.reviewWorthyActionCount = actionCount
        
        guard actionCount >= minimumReviewWorthyActionCount else { return }
        
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = defaults.lastReviewRequestAppVersion
        
        guard lastVersion == nil || lastVersion != currentVersion else { return }
        
        SKStoreReviewController.requestReview()
        defaults.reviewWorthyActionCount = 0
        defaults.lastReviewRequestAppVersion = currentVersion
    }
}
