//
//  RemoteFeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by KDZ on 7/29/25.
//

import Foundation

public final class RemoteFeedImageDataLoader: FeedImageDataLoader, @unchecked Sendable {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    private final class ResultBox: @unchecked Sendable {
        var result: Result<Data, Swift.Error>?
    }
    
    public func loadImageData(from url: URL) throws -> Data {
        let semaphore = DispatchSemaphore(value: 0)
        let box = ResultBox()
        
        Task {
            do {
                let (data, response) = try await client.get(from: url)
                let isValidResponse = response.isOK && !data.isEmpty
                box.result = isValidResponse ? .success(data) : .failure(Error.invalidData)
            } catch {
                box.result = .failure(Error.connectivity)
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try box.result!.get()
    }
}

