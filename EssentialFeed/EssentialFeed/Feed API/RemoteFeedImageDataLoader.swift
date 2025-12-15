//
//  RemoteFeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by KDZ on 7/29/25.
//

import Foundation

public class RemoteFeedImageDataLoader: FeedImageDataLoader {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public func loadImageData(from url: URL) throws -> Data {
        let semaphore = DispatchSemaphore(value: 0)
        var receivedResult: Result<Data, Swift.Error>?
        
        client.get(from: url) { result in
            receivedResult = result
                .mapError { _ in Error.connectivity }
                .flatMap { (data, response) in
                    let isValidResponse = response.isOK && !data.isEmpty
                    return isValidResponse ? .success(data) : .failure(Error.invalidData)
                }
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return try receivedResult!.get()
    }
}
