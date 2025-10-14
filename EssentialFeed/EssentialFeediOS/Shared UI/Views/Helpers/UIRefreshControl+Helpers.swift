//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by KDZ on 7/21/25.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
