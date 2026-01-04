//
//  Paginated.swift
//  EssentialFeedTests
//
//  Created by KDZ on 11/24/25.
//

import Foundation

public struct Paginated<Item: Sendable>: Sendable {
    public let items: [Item]
    public let loadMore: (@Sendable () async throws -> Self)?
    
    public init(items: [Item], loadMore: (@Sendable () async throws -> Self)? = nil) {
        self.items = items
        self.loadMore = loadMore
    }
}
