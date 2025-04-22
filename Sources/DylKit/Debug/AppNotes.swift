//
//  File.swift
//  
//
//  Created by Dylan Elliott on 25/1/2025.
//

#if canImport(UIKit)

import UIKit
import SwiftUI

private let AppNotePath = "\(UIApplication.shared.name)"

extension View {
    func showAppNoteOnShake(binding: Binding<Bool>) -> some View {
        showNoteOnShake(AppNotePath, binding: binding)
    }
}

extension UIViewController {
    func showAppNote() {
        showNote(AppNotePath)
    }
}

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
    
    @objc private func showAppNote() {
        rootViewController?.showAppNote()
    }
    
    public func showAppNoteOnShake() {
        NotificationCenter.default.addObserver(self, selector: #selector(showAppNote), name: UIDevice.deviceDidShakeNotification, object: nil)
    }
}

#endif
