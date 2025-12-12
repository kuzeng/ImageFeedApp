//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by KDZ on 8/21/25.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
