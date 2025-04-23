//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    func topAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
        safe ? safeAreaLayoutGuide.topAnchor : topAnchor
    }
    
    func bottomAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
        safe ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor
    }
    
    @discardableResult
    func pinned(to parent: UIView, on anchor: KeyPath<UIView, NSLayoutXAxisAnchor>, _ constant: CGFloat = 0) -> UIView {
        parent[keyPath: anchor].constraint(equalTo: self[keyPath: anchor], constant: constant).isActive = true
        return self
    }
    
    
    
    @discardableResult
    func pinned(to parent: UIView, on anchor: KeyPath<UIView, NSLayoutYAxisAnchor>, _ constant: CGFloat = 0) -> UIView {
        parent[keyPath: anchor].constraint(equalTo: self[keyPath: anchor], constant: constant).isActive = true
        return self
    }
    
    var bottomConstraint: NSLayoutConstraint? {
        constraints.first { $0.firstAnchor == bottomAnchor || $0.secondAnchor == topAnchor }
        ?? superview?.constraints.first { $0.firstAnchor == bottomAnchor || $0.secondAnchor == topAnchor }
    }
    
    @discardableResult
    func embedded(
        in parent: UIView,
        top: CGFloat? = 0,
        leading: CGFloat? = 0,
        bottom: CGFloat? = 0,
        trailing: CGFloat? = 0,
        safeTop: Bool = true,
        safeBottom: Bool = true,
        bottomPriority: UILayoutPriority = .required
    ) -> Self {
        guard superview == nil else { print("Can't embed view that already has superview"); return self }
        
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        
        top.ifSome{
            (safeTop ? parent.safeAreaLayoutGuide.topAnchor : parent.topAnchor)
                .pinned(to: topAnchor, -$0)
                .isActive = true
        }
        leading.ifSome{ parent.pinned(to: self, on: \.leadingAnchor, $0) }
        bottom.ifSome{
            (safeBottom ? parent.safeAreaLayoutGuide.bottomAnchor : parent.bottomAnchor)
                .pinned(to: bottomAnchor, $0, priority: bottomPriority)
                .isActive = true
        }
        trailing.ifSome{ parent.pinned(to: self, on: \.trailingAnchor, -$0) }
        
        return self
    }
    
    @discardableResult
    func embedded(
        in parent: UIView,
        all: CGFloat,
        safeTop: Bool = true,
        safeBottom: Bool = true,
        bottomPriority: UILayoutPriority = .required
    ) -> Self {
        embedded(in: parent, top: all, leading: all, bottom: all, trailing: all, safeTop: safeTop, safeBottom: safeBottom, bottomPriority: bottomPriority)
    }
    
    @discardableResult
    func verticallyPinnedTo(viewBelow: UIView, padding: CGFloat = 0) -> Self {
        bottomAnchor.pinned(to: viewBelow.topAnchor, padding).isActive = true
        return self
    }
    
    @discardableResult
    func verticallyPinnedTo(viewAbove: UIView, padding: CGFloat = 0) -> Self {
        viewAbove.bottomAnchor.pinned(to: topAnchor, padding).isActive = true
        return self
    }
    
    @discardableResult
    func pinnedToBottom(
        of parent: UIView,
        includingSides: Bool = true,
        safeBottom: Bool = true
    ) -> UIView {
        embedded(
            in: parent,
            top: nil,
            leading: includingSides ? 0 : nil,
            trailing: includingSides ? 0 : nil,
            safeBottom: safeBottom
        )
    }
    
    @discardableResult
    func pinnedToTop(
        of parent: UIView,
        padding: CGFloat = 0,
        includingSides: Bool = true,
        safeTop: Bool = true
    ) -> Self {
        embedded(
            in: parent,
            leading: includingSides ? padding : nil,
            bottom: nil,
            trailing: includingSides ? padding : nil,
            safeTop: safeTop
        )
    }
}

#endif
