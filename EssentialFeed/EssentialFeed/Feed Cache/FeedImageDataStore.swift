//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by KDZ on 8/9/25.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
