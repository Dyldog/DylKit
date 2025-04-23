//
//  File.swift
//  
//
//  Created by Dylan Elliott on 30/1/2025.
//

import SwiftUI

extension View {
    func chevroned<T: View>() -> some View {
        return HStack {
            self
            #if canImport(UIKit)
            #else
                Image(systemName: "chevron.right")
            #endif
        }
    }
}
