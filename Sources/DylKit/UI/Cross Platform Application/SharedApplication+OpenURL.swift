//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/12/2023.
//

import Foundation

#if canImport(UIKit)
import UIKit
#elseif os(OSX)
import AppKit
#endif

#if canImport(UIKit)
public extension UIApplication {
    func openURL(_ url: URL) {
        open(url)
    }
}
#elseif os(OSX)
public extension NSApplication {
    func openURL(_ url: URL) {
        NSWorkspace.shared.open(url)
    }
}
#endif
