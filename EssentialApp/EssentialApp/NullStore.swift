//
//  NullStore.swift
//  EssentialApp
//
//  Created by KDZ on 12/3/25.
//

import EssentialFeed
import Foundation

class NullStore: FeedStore & FeedImageDataStore {
    func deleteCachedFeed() throws {}
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {}
    
    func retrieve() throws -> CachedFeed? { .none }
    
    func perform(_ action: @escaping () -> Void) {
        action()
    }
    
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForURL url: URL) throws -> Data? { .none }
}
