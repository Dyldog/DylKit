//
//  DylKitDemoApp.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 21/6/2023.
//

import SwiftUI

@main
struct DylKitDemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DemoListView(demos: [
                    ("Data Storage", [
                        .init("User Defaults", UserDefaultableView()),
                        .init("Notes", NotesView())
                    ]),
                    ("UI", [
                        .init("Coloured List", ColoredListView())
                    ]),
                    ("Data Manipulation", [
                        .init("Arrays", ArrayView())
                    ])
                ])
                .navigationTitle("DylKit")
            }
        }
    }
}
