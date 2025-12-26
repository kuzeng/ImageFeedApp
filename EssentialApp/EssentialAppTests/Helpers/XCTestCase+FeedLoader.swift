//
//  XCTestCase+FeedLoader.swift
//  EssentialAppTests
//
//  Created by KDZ on 8/18/25.
//

import XCTest
import EssentialFeed

protocol FeedLoaderTestCase: XCTestCase {}

extension FeedLoaderTestCase {
    func expect(_ sut: LocalFeedLoader, toCompleteWith expectedResult: Swift.Result<[FeedImage], Error>, file: StaticString = #file, line: UInt = #line) {
        let receivedResult: Swift.Result<[FeedImage], Error>
        do {
            let feed = try sut.load()
            receivedResult = .success(feed)
        } catch {
            receivedResult = .failure(error)
        }
        
        switch (receivedResult, expectedResult) {
        case let (.success(receivedFeed), .success(expectedFeed)):
            XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
        case (.failure, .failure):
            break
        default:
            XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
}
