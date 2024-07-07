//
//  Pasteboard.swift
//
//
//  Created by Dylan Elliott on 21/10/2023.
//

#if canImport(UIKit)
    import UIKit
    public typealias Pasteboard = UIPasteboard
#else
    import AppKit
    public  typealias Pasteboard = NSPasteboard
#endif

#if canImport(UIKit)
    extension UIPasteboard {}
#else
    extension NSPasteboard {
        public var string: String? {
            get {
                string(forType: .string)
            }
            set {
                guard let newValue else { return }
                setString(newValue, forType: .string)
            }
        }
    }
#endif
