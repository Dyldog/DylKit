//
//  SheetButton.swift
//  AppApp
//
//  Created by Dylan Elliott on 21/11/2023.
//

import SwiftUI

public struct SheetButton<Title: View, Content: View>: View {
    @State var showSheet: Bool = false
    
    let title: () -> Title
    @ViewBuilder var content: Content
    let onDismiss: () -> Void
    
    init(showSheet: Bool, title: @escaping () -> Title, content: Content, onDismiss: @escaping () -> Void) {
        self._showSheet = .init(initialValue: showSheet)
        self.title = title
        self.content = content
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        SwiftUI.Button {
            showSheet = true
        } label: {
            title()
                .foregroundStyle(.blue)
        }.sheet(isPresented: $showSheet, onDismiss: onDismiss, content: {
            content
        })
    }
    
}
