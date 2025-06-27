//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/11/2023.
//

import SwiftUI

public struct Alert: Identifiable {
    public let id: UUID = .init()
    let title: String
    let message: String
    let primaryAction: (String, () -> Void)
    let secondaryAction: (String, () -> Void)?
    
    public init(
        title: String,
        message: String,
        primaryAction: (String, () -> Void) = ("OK", {}),
        secondaryAction: (String, () -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}

public extension View {
    func alert(_ binding: Binding<Alert?>) -> some View {
        self.alert(item: binding) { alert in
            if let secondaryAction = alert.secondaryAction {
                SwiftUI.Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    primaryButton: .default(Text(alert.primaryAction.0), action: alert.primaryAction.1),
                    secondaryButton: .default(Text(secondaryAction.0), action: secondaryAction.1)
                )
            } else {
                SwiftUI.Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    dismissButton: .default(Text(alert.primaryAction.0), action: alert.primaryAction.1)
                )
            }
        }
    }
}
