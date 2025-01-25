//
//  NotesView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 25/1/2025.
//

import SwiftUI
import DylKit

struct NotesView: View {
    var body: some View {
        SingleNoteView(viewModel: .init(noteName: "demo"))
    }
}

