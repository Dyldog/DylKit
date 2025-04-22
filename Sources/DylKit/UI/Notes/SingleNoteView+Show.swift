//
//  File.swift
//  
//
//  Created by Dylan Elliott on 25/1/2025.
//

#if canImport(UIKit)
import SwiftUI

extension View {
    func showNoteOnShake(_ name: String, binding: Binding<Bool>) -> some View {
        self.sheet(isPresented: binding, content: {
            SingleNoteView(viewModel: .init(noteName: name))
        })
    }
}

extension UIViewController {
    func showNote(_ name: String) {
        let noteView = SingleNoteView(viewModel: .init(noteName: name))
        let hostingController = UIHostingController(rootView: noteView)
        present(hostingController, animated: true)
    }
}
#endif
