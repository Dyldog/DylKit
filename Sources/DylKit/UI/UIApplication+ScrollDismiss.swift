//
//  File.swift
//  
//
//  Created by Dylan Elliott on 12/10/2023.
//

#if canImport(UIKit)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import SwiftUI

protocol Application {
    func endEditing(_ force: Bool)
}

var SharedApplication: Application {
#if canImport(UIKit)
    return UIApplication.shared
#elseif os(OSX)
    return NSApplication.shared
#endif
}

#if canImport(UIKit)
extension UIApplication: Application {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        SharedApplication.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

public extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
#elseif os(OSX)
extension NSApplication: Application {
    func endEditing(_ force: Bool) {
        //
    }
}
#endif
