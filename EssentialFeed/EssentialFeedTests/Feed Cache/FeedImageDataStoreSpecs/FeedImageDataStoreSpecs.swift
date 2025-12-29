//
//  FeedImageDataStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by KDZ on 12/26/25.
//

import Foundation

protocol FeedImageDataStoreSpecs {
    func test_retrieveImageData_deliversNotFoundWhenEmpty() async throws
    func test_retrieveImageData_deliversNotFoundWhenStoredDataURLDoesNotMatch() async throws
    func test_retrieveImageData_deliversFoundDataWhenThereIsAStoredImageDataMatchingURL() async throws
    func test_retrieveImageData_deliversLastInsertedValue() async throws
}
