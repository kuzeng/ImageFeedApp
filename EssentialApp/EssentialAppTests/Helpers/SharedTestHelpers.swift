//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by KDZ on 8/17/25.
//

import Foundation

func anyData() -> Data {
    Data("any data".utf8)
}

func anyNSError() -> NSError {
    return NSError(domain: "any", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}
