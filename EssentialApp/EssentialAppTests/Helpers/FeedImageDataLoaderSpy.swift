//
//  FeedImageDataLoaderSpy.swift
//  EssentialAppTests
//
//  Created by KDZ on 8/20/25.
//

import Foundation
import EssentialFeed

class FeedImageDataLoaderSpy: FeedImageDataLoader {
    private var stubbedResult: Result<Data, Error>?
    private(set) var loadedURLs = [URL]()

    func loadImageData(from url: URL) throws -> Data {
        loadedURLs.append(url)
        return try stubbedResult!.get()
    }

    func stub(with error: Error) {
        stubbedResult = .failure(error)
    }

    func stub(with data: Data) {
        stubbedResult = .success(data)
    }
}
