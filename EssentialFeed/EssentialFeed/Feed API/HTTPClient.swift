//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Kuiduan Zeng on 5/8/25.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
