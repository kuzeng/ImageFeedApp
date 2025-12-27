//
//  FeedLocalizationTests.swift
//  EssentialFeediOSTests
//
//  Created by KDZ on 7/20/25.
//

import XCTest
import EssentialFeed

@MainActor
final class FeedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
