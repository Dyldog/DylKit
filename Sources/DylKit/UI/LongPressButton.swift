//
//  File.swift
//  
//
//  Created by Dylan Elliott on 16/12/2023.
//

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

import SwiftUI

public struct LongPressButton<Label>: View where Label: View {
    let label: (() -> Label)
    let action: () -> Void
    let longPressAction: () -> Void

    public init(action: @escaping () -> Void, longPressAction: @escaping () -> Void, label: @escaping () -> Label) {
        self.label = label
        self.action = action
        self.longPressAction = longPressAction
    }

    public var body: some View {
        label()
            .onTapGesture {
                action()
            }
            .onLongPressGesture {
                longPressAction()
            }
    }
}
