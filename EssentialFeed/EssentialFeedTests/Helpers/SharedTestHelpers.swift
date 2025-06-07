//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by KDZ on 6/6/25.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}
