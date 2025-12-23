//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by KDZ on 5/30/25.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    func deleteCachedFeed() throws
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws
    func retrieve() throws -> CachedFeed?
    func perform(_ action: @escaping () -> Void)
}
