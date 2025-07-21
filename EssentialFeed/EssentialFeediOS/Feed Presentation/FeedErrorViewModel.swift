//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by KDZ on 7/21/25.
//

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }

    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
