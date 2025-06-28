//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by KDZ on 5/31/25.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
