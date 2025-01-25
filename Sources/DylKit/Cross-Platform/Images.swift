//
//  Images.swift
//
//
//  Created by Dylan Elliott on 21/10/2023.
//

import SwiftUI

#if canImport(UIKit)
    import UIKit
#else
    import AppKit

    public typealias UIImage = NSImage

    extension NSImage {
        public convenience init?(systemName: String) {
            self.init(systemSymbolName: systemName, accessibilityDescription: systemName)
        }
    }
#endif

extension UIImage {
    public convenience init?(systemName: String, pointSize: CGFloat) {
#if canImport(UIKit)
        self.init(
            systemName: systemName,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: pointSize)
        )
#else
        self.init(systemName: systemName)
#endif
    }
}

extension Image {
#if canImport(UIKit)
    public init(image: UIImage) {
        self.init(uiImage: image)
    }
#else
    public init(image: NSImage) {
        self.init(nsImage: image)
    }
#endif
}
