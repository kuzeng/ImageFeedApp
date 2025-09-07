//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by KDZ on 7/10/25.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
