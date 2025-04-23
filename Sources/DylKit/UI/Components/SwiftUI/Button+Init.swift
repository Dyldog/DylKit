//
//  File.swift
//  
//
//  Created by Dylan Elliott on 30/1/2025.
//

import SwiftUI

public extension Button {
    init(systemName: String, action: @escaping () -> Void) where Label == SwiftUI.Image {
        self.init(action: action, label: {
            Image(systemName: systemName)
        })
    }
}
