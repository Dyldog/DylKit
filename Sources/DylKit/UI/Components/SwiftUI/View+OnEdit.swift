//
//  View+OnEdit.swift
//  AppApp
//
//  Created by Dylan Elliott on 21/11/2023.
//

import SwiftUI

public extension View {
    /// Creates a button that wraps and disables the given view when `onEdit` is present
    /// - Parameter onEdit: The closure to trigger when this edit button is tapped
    /// - Returns: The edit button
    func editable(_ editing: Bool, onEdit: @escaping () -> Void, onLongPress: @escaping () -> Void) -> AnyView {
        if editing {
            LongPressButton {
                onEdit()
            } longPressAction: {
                onLongPress()
            } label: {
                self.disabled(true).background(.background)
            }
            .buttonStyle(.plain)
            .any
        } else {
            self.any
        }
    }
}
