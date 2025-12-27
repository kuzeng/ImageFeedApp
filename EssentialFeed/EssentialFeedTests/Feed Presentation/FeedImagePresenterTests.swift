//
//  FeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by KDZ on 7/23/25.
//

import XCTest
import EssentialFeed

@MainActor
class FeedImagePresenterTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let image = uniqueImage()
        
        let viewModel = FeedImagePresenter.map(image)
        
        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.location, image.location)
    }
}
