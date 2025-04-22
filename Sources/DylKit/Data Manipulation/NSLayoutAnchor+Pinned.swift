//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

#if canImport(UIKit)
import UIKit

public extension NSLayoutYAxisAnchor {
    @discardableResult
    func pinned(to anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}

#endif
