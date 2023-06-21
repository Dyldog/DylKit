//
//  DemoListView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 21/6/2023.
//

import SwiftUI

struct Demo {
    let title: String
    let view: any View
    
    init(_ title: String, _ view: any View) {
        self.title = title
        self.view = view
    }
}


enum Demos: CaseIterable {
    case userDefaults
    case coloredLists
    
    var title: String {
        switch self {
        case .userDefaults: return "User Defaults"
        case .coloredLists: return "Colored Lists"
        }
    }
    
    var view: any View {
        switch self {
        case .userDefaults: return UserDefaultableView()
        case .coloredLists: return ColoredListView()
        }
    }
}

struct DemoListView: View {
    let demos: [(section: String, demos: [Demo])]
    
    var body: some View {
        List {
            ForEach(Array(demos.enumerated()), id: \.offset) { _, section in
                Section(header: Text(section.section)) {
                    ForEach(Array(section.demos.enumerated()), id: \.offset) { _, element in
                        NavigationLink {
                            AnyView(element.view)
                                .navigationTitle(element.title)
                        } label: {
                            Text(element.title)
                        }
                        
                    }
                }
            }
        }
    }
}
