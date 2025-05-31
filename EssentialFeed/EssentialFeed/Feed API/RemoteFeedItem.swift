//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by KDZ on 5/31/25.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
