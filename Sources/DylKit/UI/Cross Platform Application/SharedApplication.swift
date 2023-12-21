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

public protocol Application {
    func endEditing(_ force: Bool)
    func openURL(_ url: URL)
}

public var SharedApplication: Application {
#if canImport(UIKit)
    return UIApplication.shared
#elseif os(OSX)
    return NSApplication.shared
#endif
}
