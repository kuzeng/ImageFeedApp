//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by KDZ on 8/18/25.
//

import EssentialFeed

class FeedLoaderStub {
    private let result: Swift.Result<[FeedImage], Error>
    
    init(result: Swift.Result<[FeedImage], Error>) {
        self.result = result
    }
    
    func load(completion: @escaping (Swift.Result<[FeedImage], Error>) -> Void) {
        completion(result)
    }
}
