//
//  ResourceLoadingView.swift
//  EssentialFeed
//
//  Created by KDZ on 10/11/25.
//

import Foundation

@MainActor
public protocol ResourceLoadingView {
    func display(_ viewModel: ResourceLoadingViewModel)
}
