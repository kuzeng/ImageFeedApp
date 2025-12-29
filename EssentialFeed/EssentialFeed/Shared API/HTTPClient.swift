//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Kuiduan Zeng on 5/8/25.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}
