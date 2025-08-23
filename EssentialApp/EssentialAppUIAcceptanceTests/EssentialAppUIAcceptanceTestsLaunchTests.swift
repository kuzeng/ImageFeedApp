//
//  EssentialAppUIAcceptanceTestsLaunchTests.swift
//  EssentialAppUIAcceptanceTests
//
//  Created by KDZ on 8/23/25.
//

import XCTest

final class EssentialAppUIAcceptanceTestsLaunchTests: XCTestCase {

    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
        let app = XCUIApplication()
        
        app.launch()
        
        XCTAssertEqual(app.cells.count, 22)
        XCTAssertEqual(app.cells.firstMatch.images.count, 1)
    }
}
