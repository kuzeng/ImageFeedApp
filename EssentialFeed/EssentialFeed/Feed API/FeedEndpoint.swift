//
//  FeedEndpoint.swift
//  EssentialFeed
//
//  Created by KDZ on 11/17/25.
//

import Foundation

public enum FeedEndpoint {
    case get

    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appendingPathComponent("/v1/feed")
        }
    }
}
