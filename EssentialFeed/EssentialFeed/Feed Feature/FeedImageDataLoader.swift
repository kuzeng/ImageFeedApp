//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by KDZ on 7/7/25.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
