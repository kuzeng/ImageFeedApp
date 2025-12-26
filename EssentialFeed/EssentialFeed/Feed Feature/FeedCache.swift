//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by KDZ on 8/19/25.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
