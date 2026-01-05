//
//  ResourceErrorView.swift
//  EssentialFeed
//
//  Created by KDZ on 10/11/25.
//

import Foundation

@MainActor
public protocol ResourceErrorView {
    func display(_ viewModel: ResourceErrorViewModel)
}
