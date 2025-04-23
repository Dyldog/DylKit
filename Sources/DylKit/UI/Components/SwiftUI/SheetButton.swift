//
//  SheetButton.swift
//  AppApp
//
//  Created by Dylan Elliott on 21/11/2023.
//

import SwiftUI

public struct SheetButton<Title: View, Content: View>: View {
    @Binding var showSheet: Bool
    
    let title: () -> Title
    @ViewBuilder var content: Content
    let onLongPress: () -> Void
    let onDismiss: () -> Void
    
    public init(
        showSheet: Binding<Bool>,
        title: @escaping () -> Title,
        @ViewBuilder content: () -> Content,
        onLongPress: @escaping () -> Void = {},
        onDismiss: @escaping () -> Void = {}
    ) {
        self._showSheet = showSheet
        self.title = title
        self.content = content()
        self.onDismiss = onDismiss
        self.onLongPress = onLongPress
    }
    
    private var button: some View {
#if canImport(UIKit)
        LongPressButton {
            showSheet = true
        } longPressAction: {
            onLongPress()
        } label: {
            title()
        }
#else
        Button {
            showSheet = true
        } label: {
            title()
        }

#endif
    }
    
    public var body: some View {
        button.sheet(isPresented: $showSheet, onDismiss: onDismiss, content: {
            content
        })
    }
}
