//
//  File.swift
//  
//
//  Created by Dylan Elliott on 12/10/2023.
//

import SwiftUI

struct ScrollViewPagingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}

public extension ScrollView {
    func paged() -> some View {
        modifier(ScrollViewPagingModifier())
    }
}
