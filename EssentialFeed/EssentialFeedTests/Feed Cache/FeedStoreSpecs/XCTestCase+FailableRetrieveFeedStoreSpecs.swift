//
//  XCTestCase+FailableRetrieveFeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by KDZ on 6/19/25.
//

import XCTest
import EssentialFeed

extension FailableRetrieveFeedStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        expectToRetrieveError(from: sut, file: file, line: line)
    }

    func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        expectToRetrieveError(from: sut, file: file, line: line)
        expectToRetrieveError(from: sut, file: file, line: line)
    }
    
    private func expectToRetrieveError(from sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        do {
            _ = try sut.retrieve()
            XCTFail("Expected retrieve to throw an error, but it succeeded", file: file, line: line)
        } catch {
            // Expected error
        }
    }
}
