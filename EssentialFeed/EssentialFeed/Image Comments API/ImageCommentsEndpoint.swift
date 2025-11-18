//
//  ImageCommentsEndpoint.swift
//  EssentialFeed
//
//  Created by KDZ on 11/17/25.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)
    
    public func url(baseURL: URL) -> URL {
        switch self {
            
        case .get(let id):
            let path = "/v1/image/\(id)/comments"
            return baseURL.appendingPathComponent(path)
        }
    }
}
