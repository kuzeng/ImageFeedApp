//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by KDZ on 8/17/25.
//

import EssentialFeed
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

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())]
}

private class DummyView: ResourceView {
    func display(_ viewModel: Any) {}
}

var loadError: String {
    LoadResourcePresenter<Any, DummyView>.loadError
}

var feedTitle: String {
    FeedPresenter.title
}

var commentsTitle: String {
    ImageCommentsPresenter.title
}
