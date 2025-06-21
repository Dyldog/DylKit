//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/6/2025.
//

import SwiftUI

// A view modifier that detects shaking and calls a function of our choosing.
public struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
public extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}
