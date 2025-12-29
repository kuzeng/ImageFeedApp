//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Kuiduan Zeng on 5/8/25.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}
