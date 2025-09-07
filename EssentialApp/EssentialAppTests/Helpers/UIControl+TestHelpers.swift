//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by KDZ on 7/10/25.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
