//
//  HTTPClientSpy.swift
//  EssentialFeedTests
//
//  Created by KDZ on 7/29/25.
//

import Foundation
import EssentialFeed

class HTTPClientSpy: HTTPClient {
    private(set) var requestedURLs = [URL]()
    private var stubbedResult: Result<(Data, HTTPURLResponse), Error>?
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        requestedURLs.append(url)
        guard let result = stubbedResult else {
            fatalError("No stubbed result set for HTTPClientSpy")
        }
        return try result.get()
    }
    
    func stub(with error: Error) {
        stubbedResult = .failure(error)
    }
    
    func stub(withStatusCode code: Int, data: Data, for url: URL) {
        let response = HTTPURLResponse(
            url: url,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        stubbedResult = .success((data, response))
    }
}
