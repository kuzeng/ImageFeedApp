//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by KDZ on 7/24/25.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}
