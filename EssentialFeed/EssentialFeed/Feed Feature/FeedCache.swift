//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by KDZ on 8/19/25.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
