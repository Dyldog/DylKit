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
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

public extension View {
    func alert(_ binding: Binding<Alert?>) -> some View {
        self.alert(item: binding) {
            SwiftUI.Alert(title: Text($0.title), message: Text($0.message))
        }
    }
}
