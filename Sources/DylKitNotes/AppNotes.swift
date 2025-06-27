//
//  File.swift
//  
//
//  Created by Dylan Elliott on 25/1/2025.
//

#if canImport(UIKit)

import DylKit
import UIKit
import SwiftUI

private let AppNotePath = "\(UIApplication.shared.name)"

struct AppNoteShakeModifier: ViewModifier {
    @State var show: Bool = false
    
    func body(content: Content) -> some View {
        content.showNoteOnShake(AppNotePath, binding: $show)
    }
}

public extension View {
    func showAppNoteOnShake() -> some View {
        modifier(AppNoteShakeModifier())
    }
}

extension UIViewController {
    func showAppNote() {
        showNote(AppNotePath)
    }
}

extension UIWindow {
    @objc private func showAppNote() {
        rootViewController?.showAppNote()
    }
    
    public func showAppNoteOnShake() {
        NotificationCenter.default.addObserver(self, selector: #selector(showAppNote), name: UIDevice.deviceDidShakeNotification, object: nil)
    }
}

#endif
