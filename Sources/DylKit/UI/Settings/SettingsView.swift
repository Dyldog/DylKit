//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/11/2023.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    let properties: [ValueKeys]
    
    init(properties: [ValueKeys]) {
        self.properties = properties
    }
    
    var rows: [(String, Binding<String>)] {
        properties.map { property in
            (property.rawValue, Binding(get: {
                property.overridable.value
            }, set: {
                property.overridable.setValue($0)
            }))
        }
    }
}

public struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel
    
    public init(properties: [ValueKeys]) {
        self._viewModel = .init(wrappedValue: .init(properties: properties))
    }
    
    public var body: some View {
        List {
            ForEach(viewModel.rows, id: \.0) { (title, value) in
                HStack {
                    Text(title.capitalized)
                    Spacer()
                    TextField(title, text: value).multilineTextAlignment(.trailing)
                }
            }
        }
        .navigationTitle("Settings")
    }
}
